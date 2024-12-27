class_name World
extends Node2D

@onready var tile_map: CustomTileMap = $TileMap

enum farming_modes {DIRT, SEEDS, WATER, HARVEST}
var farming_mode_state: farming_modes = farming_modes.DIRT

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		var mouse_pos := get_global_mouse_position()
		var ground_tile_layer := tile_map.ground_layer
		var tile_map_pos: Vector2i = ground_tile_layer.local_to_map(mouse_pos)

		ground_tile_layer.set_cell(tile_map_pos, 0, Vector2i(2, 0))

func retrieve_tile_custom_data(tile_pos: Vector2i, custom_data_layer: String, layer_if_any: TileMapLayer) -> Variant:
	if layer_if_any and layer_if_any is TileMapLayer and layer_if_any.get_cell_tile_data(tile_pos):
		return layer_if_any.get_cell_tile_data(tile_pos).get_custom_data(custom_data_layer)

	return null