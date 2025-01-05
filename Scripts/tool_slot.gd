class_name ToolSlot
extends TextureRect

@onready var selection_border: NinePatchRect = $SelectionBorder
var tool_index: World.farming_modes 

func _ready() -> void:
	selection_border.visible = false
	
func select() -> void:
	if selection_border:
		selection_border.visible = true
	
func deselect() -> void:
	if selection_border:
		selection_border.visible = false

func configure_size(new_size: Vector2) -> void:
	custom_minimum_size = new_size
	size = new_size

	await ready
	if selection_border:
		selection_border.size = new_size