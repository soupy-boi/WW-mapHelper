# WW-mapHelper
A helper mod for Wheelchair Wizards aimed to make adding maps and levels as easy as possible

## How to install 

For people looking to install the mod (most likely to make another mod work):

1.  [Download the Latest Release](https://github.com/soupy-boi/WW-mapHelper/releases/latest) and copy the zip
2.  Navigate to the correct path based on your operating system:
    - **Windows:** `%APPDATA%\Godot\app_userdata\WheelchairWizards`
    - **macOS:** `~/Library/Application Support/Godot/app_userdata/WheelchairWizards`
    - **Linux:** `~/.local/share/godot/app_userdata/WheelchairWizards`
3.  create a `mods` folder in that path (if there isnt one already)
4.  paste the zip into the `mods` folder

And thats it. This only needs to be done once, no matter how many mods you have that depend on this one.

## Adding a level

To add a level to an existing map (for example adding a new level to Forest or Desert):
First, create the level scene in your mod. This is easiest to do by copying a vanilla level from that map and modifying it.

Next, in your mod's `_ready()` function (in `mod_main.gd`) get the `MapLoader` object like so:
```gd
var mapLoader = get_node("/root/ModLoader/crea-mapHelper/MapLoader")
```

Then add the level to whatever map you want with the `add_level()` or `add_levels()` functions:
```gd
mapLoader.add_level("map name", "path to level scene") # for one level
mapLoader.add_levels("map name", ["path to first level", "path to second level"]) # for multiple
```

## Adding a map

To add a completely new map, get the `MapLoader` object just like how you would when adding a level, then simply create a new map with the `add_map()` function:
```gd
var mapLoader = get_node("/root/ModLoader/crea-mapHelper/MapLoader")
mapLoader.add_map("map name")
```

After that, levels can be added to it like normal.
