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
	if Input.is_action_just_pressed("ui_accept"):
		next_day()

	if Input.is_action_just_pressed("Interact"):
		var mouse_pos := get_global_mouse_position()
		var ground_tile_layer := tile_map.ground_layer
		var crops_tile_layer := tile_map.crops_layer
		var tile_map_pos: Vector2i = ground_tile_layer.local_to_map(mouse_pos)

		if farming_mode_state == farming_modes.DIRT:
			place_dirt(ground_tile_layer, tile_map_pos)

		if farming_mode_state == farming_modes.SEEDS:
			place_seeds(ground_tile_layer, crops_tile_layer, tile_map_pos)

		if farming_mode_state == farming_modes.WATER:
			use_water_bucket(ground_tile_layer, tile_map_pos)

		pass

func place_dirt(ground_layer: TileMapLayer, tile_map_pos: Vector2i) -> void:
	ground_layer.set_cell(tile_map_pos, 0, Vector2i(1, 0))
	print("Placed dirt")

func place_seeds(ground_layer: TileMapLayer, crops_layer: TileMapLayer, tile_map_pos: Vector2i) -> void:
	if retrieve_tile_custom_data(tile_map_pos, "place_seeds", ground_layer):
		if !retrieve_tile_custom_data(tile_map_pos, "has_seeds", crops_layer):
			crops_layer.set_cell(tile_map_pos, 1, Vector2i(0, 0))
			print("Placed seeds")

func use_water_bucket(ground_layer: TileMapLayer, tile_map_pos: Vector2i) -> void:
	if retrieve_tile_custom_data(tile_map_pos, "can_water", ground_layer):
		ground_layer.set_cell(tile_map_pos, 0, Vector2i(2, 0))
		print("Watering dirt")

func retrieve_tile_custom_data(tile_pos: Vector2i, custom_data_layer: String, layer_if_any: TileMapLayer) -> Variant:
	if layer_if_any and layer_if_any is TileMapLayer and layer_if_any.get_cell_tile_data(tile_pos):
		return layer_if_any.get_cell_tile_data(tile_pos).get_custom_data(custom_data_layer)

	return null

func next_day() -> void:
	var ground_tile_layer := tile_map.ground_layer
	var crops_tile_layer := tile_map.crops_layer
	for cell in crops_tile_layer.get_used_cells():
		var cell_seed_growth_level = retrieve_tile_custom_data(cell, "seed_growth_level", crops_tile_layer)

		if cell_seed_growth_level != 3:
			if retrieve_tile_custom_data(cell, "has_been_watered", ground_tile_layer):
				crops_tile_layer.set_cell(cell, 1, Vector2i(cell_seed_growth_level + 1, 0))

	const watered_dirt_pos := Vector2i(2, 0)
	const dirt_pos := Vector2i(1, 0)
	for cell in ground_tile_layer.get_used_cells_by_id(0, watered_dirt_pos):
		ground_tile_layer.set_cell(cell, 0, dirt_pos)