# Public emulator and encounter source survey

Ten public repositories are pinned in server-sources.json. These include actual server script/data implementations, not repack download sites or Docker wrappers. Repository metadata was fetched through GitHub; the detailed sample compares Arcanist Doan in VMaNGOS, CMaNGOS, and the exact Classic implementation bound in Everlake. No third-party code was copied into the world-data repository.

## Best immediate sources

- VMaNGOS core: Vanilla boss AI, escorts, outdoor events and progressive DB changes. Everlake already carries ports from this lineage.
- CMaNGOS mangos-classic plus classic-db: ScriptDevAI and Classic world data; useful for behavior and data comparisons, with different APIs/schema.
- Karrz1/TrinityCore forever: the directly relevant upstream. Audit pinned Everlake core and existing Custom/Classic ports before treating a script as missing.
- AzerothCore and its progression module: alternate encounter/SmartAI and bracket overrides. Wrath behavior is not automatically correct for Forever, and licenses must be checked per file/module.
- MaNGOS Zero: another Vanilla implementation; database license grant remains unresolved in this pass. MaNGOS One is a lower-priority TBC reference.
- TrinityCore upstream: framework and historical branch references. Default retail scripts may describe redesigned encounters.

The pinned core already has 235 files under Custom/Classic, including 107 boss C++ files and 30 instance C++ files. File presence does not prove every boss works or that every source is compiled. The point is to audit gaps and behavior against what is already present. Existing inventory is preserved in existing-classic-script-inventory.json.

Doan is already bound to classic_boss_arcanist_doan and map189 to classic_instance_scarlet_monastery in the read-only world. The actual Classic source identifies its VMaNGOS origin. Its contents are unchanged between the local baseline pin and inspected latest head. CMaNGOS offers different initial cooldowns and detonation sequencing, but those are research differences, not verified Forever bugs. The ordinary EasternKingdoms Doan implementation is a different script from the actual local binding; comparing it alone would audit the wrong code. See doan-crosscheck.json.

## Missing unlock follow-up

AllTheThings adds exact-ID candidate NPC sets for both shoe patterns, including Doan and several alternate bosses. It has no rate/sample/date per acquisition in these records, and independence from the other addon/Wowhead claims is not established. The cached Wowhead Warden snippet shows Doan at0.01% while the freshly opened item page has no acquisition attribution. Neither shoe is promoted to a runtime patch in this pass.

Dala's vendor terms now have exact client mappings: Forever Deadwood Tribal Beads263439, count10, equivalent cost IDs11562/11564; Barkskin Burrow faction2747; Friendly condition156318 for Jam and Honored156319 for the Bag/Lotus Claw. ATT and JudgeHype also give UI location21.0,78.6 Mount Hyjal. The correct current bead is not the Classic item21377. UI coordinates cannot supply a verified server map/height/orientation/phase or a complete creature template. These three acquisition paths remain blocked by NPC/spawn and current stock verification. No zero-cost or invented spawn rows were added.

Ziri's nine recipe leads remain held. A player report after a Gnomeregan clear says she was absent and identifies the SoD origin. This strengthens the historical-source concern, but is anecdotal and not proof of permanent unavailability. Source and date-rendering ambiguity are retained in unlock-source-followup.json.

## Integration order

1. Start with actual Everlake ScriptName/AIName and map instance bindings; resolve loader registration and compiled code before claiming a gap.
2. Match one encounter's IDs, spells, difficulty, phase, doors, summons and quest credit against Forever observations and at least one appropriate historical implementation.
3. Record shared ancestry; VMaNGOS/CMaNGOS/ScriptDev2 agreement is not an independent live observation.
4. Port the minimal verified behavior into the matching core API, or generate guarded world-data changes if the problem is a binding/SmartAI row. Preserve license notices and check compatibility first. AGPL modules and unresolved database grants are not automatically reusable in a GPL-2-only target.
5. Validate in an isolated database and matching core build, then run an in-game encounter smoke test. Never bulk-load another emulator database over Everlake.

This research set changes no gameplay rows and claims zero new spell unlocks. Another active session is handling merchant cost/reputation corrections and non-item spell learning; shared DB/common evidence files were untouched.
