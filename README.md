# BLK_LowSuppliesWarning Tracker

## Header
- Name: Low Supplies Warning
- ModCode: LSW
- Plugin: `BLK_LowSuppliesWarning.esp` (ESL-flagged: planned, not flagged yet)
- Type: Feature
- Status: In development
- Current version: none yet (target 1.0.0)
- Nexus link:

## Pitch
The game tells you when your equipped arrows or your lockpicks run low, once, before you're caught empty-handed in a fight or in front of a locked chest.

## Design
### Core mechanics
- Track lockpicks and the currently equipped ammo.
- Warn once when the count drops to or below the threshold.
- Reset the warning when the count rises above the threshold again.
- Default thresholds: arrows 20, lockpicks 10.

### Player-facing behaviour (settings, messages, MCM)
- Notification text: TBD.
- Thresholds stored in GlobalVariables.
- MCM (optional, needs SKSE + SkyUI): thresholds, enable/disable per item type. Core works without it.

### Out of scope (deliberately not doing)
- Everything in "Post-1.0 ideas" below.

### Open questions
- How to know the equipped ammo after loading a save (no known vanilla getter). Decide at milestone M4.
- Do bolts count as "arrows"? (Equipped ammo tracking would include them automatically.)
- Verify in test: firing arrows and breaking lockpicks trigger OnItemRemoved.

### Post-1.0 ideas
- Potions (health, magicka, stamina)
- Torches
- Repair items / smithing materials
- Sound effect with the warning

## Technical Design
### Engine systems used
- Start Game Enabled quest, player ReferenceAlias, inventory events with filters, GlobalVariables, load-game maintenance.

### Flow (pseudocode)
```
on item removed (lockpick or tracked ammo):
    count = player.GetItemCount(item)
    if count <= threshold and not warned(item): notify, mark warned
on item added (same items):
    if count > threshold: reset warned flag
on ammo equipped:
    swap the inventory filter to the new ammo
```

### Milestones
| # | Milestone | Status |
|---|---|---|
| M0 | Tool setup | done (xEdit still to install before release) |
| M1 | Quest starts, logs a line | done |
| M2 | Lockpick warning via player alias | next |
| M3 | Warn once + reset, GlobalVariable thresholds | |
| M4 | Equipped ammo tracking | |
| M5 | Load-game maintenance + version | |
| M6 | MCM (soft dependency) | |

## Dependencies
| Dependency | Why needed | Hard / Soft |
|---|---|---|
| SKSE | MCM only | Soft |
| SkyUI | MCM only | Soft |

## Records Registry
| EditorID | Record type | Purpose | Notes |
|---|---|---|---|
| BLK_LSW_MainQuest | Quest | Hosts scripts and player alias | Created. Start Game Enabled. Name "Low Supplies Warning" |
| BLK_LSW_ArrowThreshold | GlobalVariable | Arrow threshold | Default 20 (planned) |
| BLK_LSW_LockpickThreshold | GlobalVariable | Lockpick threshold | Default 10 (planned) |

## Scripts Registry
| Script | Extends | Attached to | Purpose | Key properties |
|---|---|---|---|---|
| BLK_LSW_MainQuestScript | Quest | BLK_LSW_MainQuest | Currently: OnInit test (trace + notification). Later: maintenance, version | none yet |
| BLK_LSW_PlayerAliasScript | ReferenceAlias | Player alias | Inventory and equip events | (planned) |

## Save-Game Notes
- Persistent data: TBD
- Upgrade path (version number, Maintenance steps): TBD (M5)
- Uninstall safety: TBD

## Known Issues / TODO
- Install SSEEdit, then ESL-flag the plugin and check the header version before release.
- Remove or replace the OnInit test notification before release.

## Decision Log
| Date | Decision | Reason |
|---|---|---|
| 2026-10-04 | Name "Low Supplies Warning", code LSW, plugin BLK_LowSuppliesWarning.esp | Descriptive, unique code |
| 2026-10-04 | 1.0 scope: lockpicks + equipped arrows, defaults 20 arrows / 10 lockpicks | Keep first mod small |
| 2026-10-04 | No separate SKSE-free Stock Game copy; test vanilla via profile/launcher instead | Installing SKSE does not create a dependency |
| 2026-10-05 | Compile via VS Code build task (tasks.json) instead of extension project files | Transparent, output goes straight into the mod folder |
| 2026-10-05 | Git repo lives inside the MO2 mod folder; .vscode ignored | Git tracks exactly what MO2 loads; tasks.json holds machine-specific paths |

## Changelog
| Version | Date | Save safety | Changes |
|---|---|---|---|
| | | | |
