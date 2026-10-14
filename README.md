# Low Supplies Warning

A small Skyrim Special Edition mod: the game tells you when your equipped arrows or your lockpicks run low, once, before you're caught empty-handed in a fight or in front of a locked chest.

> **Status:** Released (v1.0.0)

## Features
- Warns you when your **lockpicks** drop to or below a threshold.
- Warns you when your **equipped arrows** drop to or below a threshold.
- Each warning appears **once**. It resets when you restock above the threshold.
- Default thresholds: **20 arrows**, **10 lockpicks**.
- Optional MCM menu to change the thresholds and turn each warning on or off. The mod works without it.
- Optional first person messages via MCM or when playing survival mode.

## Requirements
| Requirement | Needed for |
|---|---|
| Skyrim Special Edition | Core mod |
| SKSE64 | Optional, only for the MCM menu |
| SkyUI | Optional, only for the MCM menu |

No Anniversary Edition content is required.

## Installation
Install with the “Mod Manager Download” button (Vortex or Mod Organizer 2).
For manual installation, extract the archive into your Skyrim Special Edition\Data folder.

Installing on an existing save? Re-equip your arrows once so the mod picks them up.

## Compatibility
Low Supplies Warning only adds new records and does not change any vanilla records, so it is compatible with almost everything.
Works on Skyrim SE/AE 1.6.1130 and newer. Older versions (including 1.5.97) need Backported Extended ESL Support.

## Uninstalling
Removing the mod mid-playthrough is at your own risk. It leaves small orphaned script data in your save. This is unlikely to cause problems, but it can’t be ruled out. If you want a clean save, remove the leftovers with ReSaver.

## Ideas for later versions
No promises, but possible additions:
- Potions (health, magicka, stamina)
- Torches
- A sound effect with the warning

## Changelog
### 1.0.0 (2026-10-13)
Initial release.

### 1.0.1 (2026-10-14)
**Save safety:** Safe to update mid-game.

**Added**
- First-person option for the warning messages ("I'm running low on arrows"), toggleable in the MCM.
- The first-person option turns on automatically the first time Survival Mode is enabled, unless you've already changed the setting yourself.

**Changed**
- Removed the debug startup message.
- The download archive no longer includes `README.md` and `LICENSE.txt`. The license still applies; both files remain available on GitHub.

## License
CC BY-NC 4.0, see LICENSE.txt. Translations, ports and patches are welcome without asking, as long as you credit the original.

## Author
BLK
