extends "res://Scripts/Maps/MapSpawner.gd"

const LOG_NAME := "crea-mapHelper:MapSpawnerExtension" # Full ID of the mod (AuthorName-ModName)


func _ready() -> void:
    var loader = get_node("/root/ModLoader/crea-mapHelper/MapLoader")
    loader.load_maps(maps)
 
    for m in maps:
        loader.load_map_levels(m)

    super()


# as much as I hate to completely overrite a class function (cause its a huge risk for mods trying to extend it), i cannot seem to get around the if num == 3 check.
func load_map():
    if is_multiplayer_authority():
        var rng = RandomNumberGenerator.new()
        var num = %MapButton.selected
        if num == (maps.size() + 1):
            num = rng.randi_range(0, maps.size() - 1)
        var map = maps[num]
        var value = rng.randi_range(0, map.Levels.size() - 1)
        var data = {
            "map_id": num, 
            "level_id": value, 
        }
        spawn(data)
        $PlayerSpawner._setupPlayers(loaded_map)