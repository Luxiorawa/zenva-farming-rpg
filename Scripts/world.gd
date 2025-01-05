class_name World
extends Node2D

@onready var tile_map: CustomTileMap = $TileMap

enum farming_modes {EMPTY_HAND, DIRT, SEEDS, WATER, HARVEST}

const TOOLS_CONFIG: Dictionary = {
    farming_modes.DIRT: {
        "sprite": "",
        "name": "Dirt Tool"
    },
    farming_modes.SEEDS: {
        "sprite": "",
        "name": "Seeds Tool"
    },
    farming_modes.WATER: {
        "sprite": "./../Assets/Sprites/Items/water-bucket.png",
        "name": "Water Tool"
    },
    farming_modes.HARVEST: {
        "sprite": "",
        "name": "Harvest Tool"
    }
}

var farming_mode_state: farming_modes = farming_modes.DIRT

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		var mouse_pos := get_global_mouse_position()
		var ground_tile_layer := tile_map.ground_layer
		var crops_tile_layer := tile_map.crops_layer
		var tile_map_pos: Vector2i = ground_tile_layer.local_to_map(mouse_pos)

		if farming_mode_state == farming_modes.DIRT:
			print("Placing dirt")
			place_dirt(ground_tile_layer, tile_map_pos)

		if farming_mode_state == farming_modes.SEEDS:
			print("Placing seeds")
			place_seeds(ground_tile_layer, crops_tile_layer, tile_map_pos)

		pass

func place_dirt(ground_layer: TileMapLayer, tile_map_pos: Vector2i) -> void:
	ground_layer.set_cell(tile_map_pos, 0, Vector2i(1, 0))

func place_seeds(ground_layer: TileMapLayer, crops_layer: TileMapLayer, tile_map_pos: Vector2i) -> void:
	if retrieve_tile_custom_data(tile_map_pos, "place_seeds", ground_layer) == true:
		crops_layer.set_cell(tile_map_pos, 1, Vector2i(0, 0))

func retrieve_tile_custom_data(tile_pos: Vector2i, custom_data_layer: String, layer_if_any: TileMapLayer) -> Variant:
	print("Checking layer ", layer_if_any, " at pos ", tile_pos, " for custom_data named ", custom_data_layer)
	if layer_if_any and layer_if_any is TileMapLayer and layer_if_any.get_cell_tile_data(tile_pos):
		return layer_if_any.get_cell_tile_data(tile_pos).get_custom_data(custom_data_layer)

	return null