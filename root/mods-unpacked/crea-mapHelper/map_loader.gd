class_name MapLoader
extends Node

const LOG_NAME = "crea-mapHelper:mapLoader"
var mod_dir = ""

var custom_maps: Array[Map] = []
var custom_levels: Dictionary[String, Array] = {} # map name : [(loaded) level scene] 

func _init(mod_dir_: String) -> void:
    mod_dir = mod_dir_


func _ready() -> void:
    pass

func _add_level(map_name: String, scene_path: String) -> bool:
    var loaded_level = load(scene_path)
    if loaded_level == null:
        return false
    
    if map_name not in custom_levels.keys():
        custom_levels.set(map_name, [])

    custom_levels[map_name].append(loaded_level)
    return true    

func add_level(map_name: String, level_path: String) -> void:
    if _add_level(map_name, level_path):
        ModLoaderLog.debug("added level '%s' to the map '%s'." % [level_path, map_name], LOG_NAME)
    else:
        ModLoaderLog.error("added to load level '%s' to the map '%s'." % [level_path, map_name], LOG_NAME)

func add_levels(map_name: String, level_paths: Array) -> void:
    var failed := 0
    var succeeded := 0

    for l in level_paths:
        if _add_level(map_name, l):
            succeeded += 1

    ModLoaderLog.debug("attempted to add %d levels to the map '%s'. (%d succeeded, %d failed)" % [succeeded + failed, map_name, succeeded, failed], LOG_NAME)

func add_map(map_name: String):
    var map: Map = Map.new()
    map.MapName = map_name
    
    if map.Levels.size() == 0:
        map.Levels = [] as Array[PackedScene]
    custom_maps.append(map)

func load_maps(spawner_maps: Array) -> void:
    var mapButton: OptionButton = get_tree().current_scene.get_node("%MapButton")

    mapButton.remove_item(mapButton.item_count - 1) # assuming the last item is the "All Maps" option
    for m in custom_maps:
        spawner_maps.append(m)
        mapButton.add_item(m.MapName)
        ModLoaderLog.debug("added map '%s'." % m.MapName, LOG_NAME)

    mapButton.add_item("All Maps")

func load_map_levels(map: Map) -> void:
    var map_name = map.MapName

    if map_name not in custom_levels.keys():
        ModLoaderLog.debug("No levels found for '%s', skipping." % map_name, LOG_NAME)
        return

    var failed := 0
    var succeeded := 0
    for l in custom_levels.get(map_name):
        # todo: add a check to somehow see if a level fails to get added (maybe even see if other players have it?) and increment `failed`
        map.Levels.append(l)
        succeeded += 1

    ModLoaderLog.debug("attempted to insert %d levels into '%s'. (%d succeeded, %d failed)" % [succeeded + failed, map_name, succeeded, failed], LOG_NAME)
    
