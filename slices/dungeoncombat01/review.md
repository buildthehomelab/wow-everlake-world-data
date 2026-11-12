# Provisional Mutanus combat rotation

Refs #48; keep the issue open for live Forever target/timing verification. This slice adds three SmartAI cast rows, all visibly marked PROVISIONAL in row comments, import provenance and manifest. It is a historical Classic fallback, not a claim of exact Forever behavior or a SoD raid import.

The rebuilt world binds Mutanus3654 to SmartAI with only a death row. Template spell slots contain Naralex's Nightmare7967, Terrify7399 and Thundercrack8150. SmartAI derives from CreatureAI and its inspected UpdateAI processes SmartScript events; it does not inherit CombatAI's slot-driven rotation. The shared DBM WC module lists these same three spells and has Forever support, but supplies adaptive timers rather than an exact cast schedule.

CMaNGOS ACID provides the provisional schedule: Thundercrack self, initial0–10s/repeat10–16s; Nightmare random non-top player, initial6–11s/repeat25–36s; Terrify random threat target, initial15–21s/repeat18–24s. The source target enum and CAST_PLAYER_ONLY bit were checked: EventAI target5/player-only512 becomes SmartAI target6 with target_param2=1, while random target4 becomes SmartAI target5. EventAI repeatable flags become SmartAI event_flags0 (repetition enabled). We do not assert identical cast-failure retry behavior across engines; targets and cadence remain provisional under issue48.

The SQL inserts IDs900–902 only under the expected Classic instance/escort/Mutanus bindings and known inherited death row. Any other rotation or row override blocks insertion. The death row is preserved, so the separate PR44 ritual-state correction composes with this slice in either order.

## Validation

Private schema codex_dungeoncombat_01a1c7e8 used a consistent read-only world snapshot. Three rows inserted, all39 preexisting SmartAI rows preserved, replay unchanged, and all10 SQL statements accepted by the core rewrite/parser. Applying this slice and PR44 in either order converged to identical SmartAI data; both replayed unchanged. Other-script, other-instance, missing-escort, partial-rotation and unknown-death guards passed. Client70862 contains the three spell IDs. No full-core build or in-game combat run was performed. Shared world/common evidence files were untouched.

## Continued three-dungeon audit

22 primary DBM modules were compared with actual local SmartAI and existing bound Classic C++ paths. Four inspected Scarlet Monastery C++ boss scripts contain the announced spell IDs. Vishas casts Shadow Word: Pain2767 while DBM references9034; this variant is retained for issue47 rather than adding a duplicate SmartAI rotation. Absent SmartAI rows alone are not treated as gaps. Old Serra'kis already carries Leech Pulse8434 through addon data. Kresh is NSR in ACID and has no DBM combat-spell announcements. Faerie Dragon's missing Slumber path remains issue46; Gelihast and fang-boss variant differences remain issue47. Existing abilities are not replaced on the strength of a name match.

SoD BFD modules were inspected and pinned. Aku'mai uses SoD NPC213334 versus dungeon4829; Ghamoo-ra201722 versus4887; Kelris209678 versus4832. Their explicit SoD gating and separate encounter IDs are recorded in sources.json. Those raid definitions are available for future placeholders but are not applied to these already implemented five-player bosses.

Replacement policy: collect a live Forever combat trace for spell IDs, targets and cadence, update issue48 with evidence, and add a new guarded SQL migration for corrections. Do not edit the deployed placeholder file or silently promote its confidence. The remaining issues stay open; this PR claims zero new player spell unlocks.
