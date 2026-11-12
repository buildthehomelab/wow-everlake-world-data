# Wailing Caverns ritual state correction

Fixes #42. Killing Mutanus currently fires SmartAI action34 with parameters4,3,1. The third parameter selects SetBossState, so this marks boss4 (Skum) done. It does not set the Classic ritual state that the Disciple waits for. The escort remains in its post-Mutanus wait branch.

Change the inherited row to parameters5,3,0: SetData(CWC_TYPE_MUTANUS=5,DONE=3). The Classic instance then records Mutanus completion and its existing cleanup behavior; the escort can awaken Naralex and set its own completion state. The separate encounter tracker already completes Mutanus boss index7. No new summon, loot or spell behavior is added.

Evidence follows the actual source contract at core343fe6fb: SmartScript.cpp action34 dispatch, Classic WC header, instance SetData/GetData, escort phase8 and the separate encounter tracker. See source-contracts.json for pinned source URLs/hashes. The correction is guarded against the complete old row payload plus expected map43 instance, Mutanus SmartAI, Disciple binding and map43 spawn. An explicit existing override or different binding is left unchanged.

## Validation

A consistent read-only world snapshot supplied private schema codex_dungeonbindings_01a1c7e8. The SQL changed exactly one of300 copied SmartAI rows; unrelated rows were unchanged and replay affected zero rows. Five negative cases passed: other instance binding, other Mutanus AI, other Disciple binding, existing-row override and missing Disciple spawn. The core SQL rewrite/parser accepted the statement.

A clang++ C++17 harness compiled the actual pinned SmartScript dispatch case and Classic instance SetData/GetData methods. Inputs came from the SQL-applied row in private MySQL. The old payload marked Skum and left the ritual pending; the corrected payload completed the ritual while leaving Skum untouched. Unrelated creature/world operations were stubbed. This is a source-contract test, not a full server build or in-game run. An in-game ritual run from the four fang bosses through Mutanus, awakening and exit remains required.

## Three-dungeon audit

First-pass checks covered map43,48,189 instance bindings,10 registered creature/gameobject AI names (including summoned-only Scarlet Trainee),93 spawned creature templates,132 spawned gameobject templates, and13 critical summon dependencies. Script loader calls and CMake source collection were inspected; actual live build options were not verified.

Scarlet Monastery has the five Classic boss source bindings, trainee AI, Herod lever, Mograine/Whitemane SmartAI state1 handoff, and area trigger4089. Blackfathom has the four fire object bindings, Kelris SetData10 death handoff and Fathom Stone/Aquanis summon path. Wailing Caverns has the escort/menu/summon bindings and four fang-boss keys0–3. The Mutanus mismatch is the single verified correction from this pass. No full combat-mechanics certification is claimed.

Rathiril Sunlance's live disappearance after giving A Magical Affront is deferred to issue #39. Its local static spawn/quest links exist; no duplicate was added. Source-blocker research is tracked separately in issues #40, #41 and #43.

No shared world rows or common evidence documents were changed. The other session is working on class quest/spell reward paths; this patch uses a separate branch and unique files. Runtime deployment is not performed by this PR.
