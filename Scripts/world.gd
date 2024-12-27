class_name World
extends Node2D

@onready var tile_map: CustomTileMap = $TileMap

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		var mouse_pos := get_global_mouse_position()
		var ground_tile_layer := tile_map.ground_layer
		var tile_map_pos: Vector2i = ground_tile_layer.local_to_map(mouse_pos)

		ground_tile_layer.set_cell(tile_map_pos, 0, Vector2i(2, 0))
