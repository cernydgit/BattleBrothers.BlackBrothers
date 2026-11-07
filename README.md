# Black Brothers (Battle Brothers mod)

Adds a new starting scenario, **Black Brothers**, and a unique helmet, the **Owl Helmet**.

## Scenario: Black Brothers

You start with three level 2 men. Each has one unspent perk point and one pending level-up.
Their random traits are replaced with hand-picked ones, and their level-up rolls follow their talents.

| Character | Background | Talents (stars) | Traits | Equipment |
| --- | --- | --- | --- | --- |
| **the Blade** (swordsman) | Sellsword | Melee Skill 3, Initiative 3, Melee Defense 2 | Dexterous, Quick, Brave | Shortsword, Gambeson, **Owl Helmet** |
| **the Wall** (tank) | Hedge Knight | Melee Defense 3, Fatigue 3, Hitpoints 3 | Tough, Iron Lungs, Sure Footing | Bludgeon, Wooden Shield, Basic Mail Shirt, Nasal Helmet |
| **the Owl** (archer) | Hunter | Ranged Skill 3, Initiative 3, Ranged Defense 2 | Night Owl, Quick, Eagle Eyes | Short Bow, Quiver of Arrows, Leather Tunic, Hunter's Hat, Dagger (bag) |

The company starts near a small non-military northern town. A short intro event opens the campaign.
Gold, tools, medicine and ammo are the game defaults for the chosen economic difficulty.

## Item: Owl Helmet

- Unique (named) light helmet, built on the vanilla Mail Coif look.
- 80 durability, -4 maximum fatigue, **no vision penalty**.
- Its wearer is **not affected by nighttime penalties**. While it is worn, it adds a hidden effect
  (`effects.owl_helmet`) that sets `IsAffectedByNight = false` before the vanilla night effect runs.
  Unequipping the helmet removes the effect.

The scenario puts the Owl Helmet on the Blade, because the Owl already has the Night Owl trait.
Move it to whoever you like.

## Requirements and compatibility

- Battle Brothers, vanilla. No DLC and no hook library needed.
- No vanilla files are overwritten. The mod only adds new scripts:
  - `scripts/scenarios/world/black_brothers_scenario.nut`
  - `scripts/events/events/scenario/black_brothers_intro_event.nut`
  - `scripts/items/helmets/owl_helmet.nut`
  - `scripts/skills/effects/owl_helmet_effect.nut`
- Not tested with Legends; Legends replaces the scenario system and may not show the scenario.

## Installation

Zip the `scripts` directory (at the zip root) as `mod_black_brothers.zip` and put it into `Battle Brothers/data`.

```powershell
Compress-Archive -Path scripts -DestinationPath "..\..\..\data\mod_black_brothers.zip" -Force
```

Start a new campaign and pick **Black Brothers** from the origin list.
