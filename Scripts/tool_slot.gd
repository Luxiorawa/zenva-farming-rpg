class_name ToolSlot
extends TextureRect

@onready var selection_border: NinePatchRect = $SelectionBorder

func _ready() -> void:
	if selection_border:
		selection_border.visible = false
	else:
		push_error("SelectionBorder node not found in ToolSlot!")
	
func select() -> void:
	if selection_border:
		selection_border.visible = true
	
func deselect() -> void:
	if selection_border:
		selection_border.visible = false