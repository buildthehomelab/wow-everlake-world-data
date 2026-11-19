#!/usr/bin/env python3
"""Apply every update file to a fresh copy of the PTR's world, as the worldserver does, and check that the files a
change touches run a second time without changing anything.

    python3 ci/check_sql.py [--changed FILE ...] [--keep]

What it builds (the same world the PTR image builds, see wow-project-everlake's Dockerfile):
  1. MySQL 8.0 with its default settings (as the realm's own mysql:8.0), in a Docker container.
  2. The Forever TDB world dump the image imports (TDB_URL from wow-project-everlake's Dockerfile).
  3. The core's world update files at the PTR's core commit (PTR_TC_COMMIT in its docker-compose.ptr.yml), from the
     directories the world's `updates_include` table names, plus this repository's sql/world files as part of
     sql/custom/world. All of them sorted by file name, as the core's UpdateFetcher sorts them, skipping names the
     dump's `updates` table already lists, each applied with the mysql client over a utf8mb4 connection, as the
     core's DBUpdater does. A file that fails stops the run: the worldserver would stop on it too.
  4. Each file in --changed is applied again; a table it writes to whose CHECKSUM changes fails the check (README:
     running a file again changes nothing).

Also checked without a database: file names (the pattern the image accepts) and names the core already uses.

Environment: CORE_COMMIT, TDB_URL override what is read from wow-project-everlake's main branch; PROJECT_REF picks
another branch of it. Needs docker, git, curl and 7z (p7zip).
"""
import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
import urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
PROJECT = 'buildthehomelab/wow-project-everlake'
CORE_REPO = 'https://github.com/buildthehomelab/wow-trinitycore-everlake.git'
CONTAINER = 'world-data-ci-db'
NAME = re.compile(r'^\d{4}_\d{2}_\d{2}_(\d{2}|\d{3})_world_everlake_.+\.sql$')
WRITES = re.compile(r'\b(?:INSERT(?:\s+IGNORE)?\s+INTO|REPLACE\s+INTO|UPDATE|DELETE\s+FROM)\s+`?([A-Za-z0-9_]+)`?', re.I)
GITHUB = os.environ.get('GITHUB_ACTIONS') == 'true'


def log(text):
    print(text, flush=True)


def fail(text, path=None):
    if GITHUB:
        where = f' file={os.path.relpath(path, REPO)}' if path else ''
        print(f'::error{where}::' + text.replace('\n', '%0A'), flush=True)
    else:
        print('ERROR: ' + text, file=sys.stderr, flush=True)
    sys.exit(1)


def run(cmd, **kw):
    return subprocess.run(cmd, check=True, **kw)


def project_file(path):
    ref = os.environ.get('PROJECT_REF', 'main')
    with urllib.request.urlopen(f'https://raw.githubusercontent.com/{PROJECT}/{ref}/{path}', timeout=60) as r:
        return r.read().decode()


def pins():
    core = os.environ.get('CORE_COMMIT')
    if not core:
        m = re.search(r'PTR_TC_COMMIT:-([0-9a-f]{40})', project_file('docker-compose.ptr.yml'))
        core = m and m.group(1)
    tdb = os.environ.get('TDB_URL')
    if not tdb:
        m = re.search(r'^ARG TDB_URL=(\S+)', project_file('Dockerfile'), re.M)
        tdb = m and m.group(1)
    if not core or not tdb:
        fail(f'could not read the PTR core commit or the TDB URL from {PROJECT}')
    return core, tdb


def sql(query, db='world'):
    out = run(['docker', 'exec', CONTAINER, 'mysql', '-uroot', '-pci', '--default-character-set=utf8mb4', '-N', '-B',
               db, '-e', query], capture_output=True, text=True).stdout
    return [line.split('\t') for line in out.splitlines()]


def apply(path):
    """Apply one file as DBUpdater does (mysql client, utf8mb4); (ok, error text)."""
    with open(path, 'rb') as handle:
        r = subprocess.run(['docker', 'exec', '-i', CONTAINER, 'mysql', '-uroot', '-pci', '--default-character-set=utf8mb4',
                            '--max-allowed-packet=1GB', 'world'], stdin=handle, capture_output=True)
    err = '\n'.join(line for line in r.stderr.decode(errors='replace').splitlines() if 'password on the command line' not in line)
    return r.returncode == 0, err


def start_db():
    subprocess.run(['docker', 'rm', '-f', CONTAINER], capture_output=True)
    run(['docker', 'run', '-d', '--name', CONTAINER, '-e', 'MYSQL_ROOT_PASSWORD=ci', 'mysql:8.0'], capture_output=True)
    for _ in range(120):
        r = subprocess.run(['docker', 'exec', CONTAINER, 'mysql', '-uroot', '-pci', '-e', 'SELECT 1'], capture_output=True)
        if r.returncode == 0:
            return
        time.sleep(2)
    fail('MySQL did not start')


def checksums(tables):
    if not tables:
        return {}
    rows = sql('CHECKSUM TABLE ' + ', '.join(f'`{t}`' for t in sorted(tables)))
    return {r[0].split('.', 1)[1]: r[1] for r in rows}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--changed', nargs='*', default=[], help='sql/world files to run a second time')
    ap.add_argument('--keep', action='store_true', help='leave the database container running')
    ap.add_argument('--work', help='folder for the downloads (default: a temporary one)')
    args = ap.parse_args()

    ours = sorted(os.path.join(REPO, 'sql', 'world', f) for f in os.listdir(os.path.join(REPO, 'sql', 'world')))
    for path in ours:
        if not NAME.match(os.path.basename(path)):
            fail(f'{os.path.basename(path)}: not a name the image accepts (YYYY_MM_DD_NN[N]_world_everlake_*.sql)', path)

    core, tdb = pins()
    log(f'core {core}\nTDB  {tdb}')
    work = args.work or tempfile.mkdtemp(prefix='world-data-ci-')
    os.makedirs(work, exist_ok=True)
    coredir = os.path.join(work, 'core')
    if not os.path.isdir(os.path.join(coredir, '.git')):
        run(['git', 'init', '-q', coredir])
        run(['git', '-C', coredir, 'remote', 'add', 'origin', CORE_REPO])
        run(['git', '-C', coredir, 'sparse-checkout', 'set', 'sql'])
    run(['git', '-C', coredir, 'fetch', '-q', '--depth', '1', '--filter=blob:none', 'origin', core])
    run(['git', '-C', coredir, 'checkout', '-q', 'FETCH_HEAD'])

    dump = [f for f in os.listdir(work) if f.startswith('TDB_full_world') and f.endswith('.sql')]
    if not dump:
        log('downloading the TDB')
        run(['curl', '-fsSL', '--retry', '3', '-o', os.path.join(work, 'tdb.7z'), tdb])
        seven = shutil.which('7z') or shutil.which('7zz') or fail('7z (p7zip) is needed')
        run([seven, 'e', '-y', f'-o{work}', os.path.join(work, 'tdb.7z'), 'TDB_full_world*.sql', '-r'], capture_output=True)
        os.remove(os.path.join(work, 'tdb.7z'))
        dump = [f for f in os.listdir(work) if f.startswith('TDB_full_world') and f.endswith('.sql')]
    if len(dump) != 1:
        fail(f'expected one TDB_full_world*.sql in the TDB, found {dump}')
    dump = os.path.join(work, dump[0])
    # as the image's Dockerfile does: views with a DEFINER need SUPER
    run(['sed', '-i.bak', '-E', r's#/\*!50013 DEFINER=`[^`]*`@`[^`]*` SQL SECURITY DEFINER \*/##', dump])

    start_db()
    t = time.time()
    run(['docker', 'exec', CONTAINER, 'mysql', '-uroot', '-pci', '-e',
         'CREATE DATABASE world DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci'], capture_output=True)
    ok, err = apply(dump)
    if not ok:
        fail(f'the TDB dump did not import: {err[-2000:]}')
    log(f'TDB imported in {time.time() - t:.0f} s')

    # the files the updater would see: updates_include's directories ($ = the core's source root), ours in custom/world
    files = {}
    for path, state in sql('SELECT `path`, `state` FROM `updates_include`'):
        folder = path.replace('$', coredir, 1)
        if not os.path.isdir(folder):
            continue
        for root, _, names in os.walk(folder):
            for n in names:
                if n.endswith('.sql'):
                    files.setdefault(n, os.path.join(root, n))
    for path in ours:
        n = os.path.basename(path)
        if n in files:
            fail(f'{n} has the name of a core file ({os.path.relpath(files[n], coredir)}): the image refuses it', path)
        files[n] = path
    done = {r[0] for r in sql('SELECT `name` FROM `updates`')}
    todo = [n for n in sorted(files) if n not in done]
    log(f'{len(todo)} update files to apply ({sum(1 for n in todo if files[n] in ours)} of them from this repository)')

    t = time.time()
    for n in todo:
        start = time.time()
        ok, err = apply(files[n])
        if not ok:
            fail(f'{n} failed, so the worldserver would stop here:\n{err[-3000:]}', files[n] if files[n] in ours else None)
        if time.time() - start > 30:
            log(f'  {n}: {time.time() - start:.0f} s')
    log(f'all {len(todo)} applied in {time.time() - t:.0f} s')

    for name in args.changed:
        path = os.path.join(REPO, name) if not os.path.isabs(name) else name
        if not os.path.exists(path) or not path.endswith('.sql'):
            continue
        text = open(path, encoding='utf-8', errors='replace').read()
        tables = {m.group(1) for m in WRITES.finditer(text)}
        tables = {t for t in tables if sql(f"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'world' AND table_name = '{t}'")[0][0] == '1'}
        before = checksums(tables)
        ok, err = apply(path)
        if not ok:
            fail(f'{os.path.basename(path)} fails when it runs a second time:\n{err[-3000:]}', path)
        after = checksums(tables)
        changed = sorted(t for t in tables if before.get(t) != after.get(t))
        if changed:
            fail(f'{os.path.basename(path)} changes {", ".join(changed)} when it runs a second time', path)
        log(f'second run of {os.path.basename(path)}: no change ({len(tables)} tables)')

    if not args.keep:
        subprocess.run(['docker', 'rm', '-f', CONTAINER], capture_output=True)
    log('ok')


if __name__ == '__main__':
    main()
