class_name ToolBar
extends Control

@export var slot_size := Vector2(64, 64)
@export var slot_spacing := 4

var slots: Array[ToolSlot] = []

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Toolbar1"):
		slots[0].select()
	elif event.is_action_pressed("Toolbar2"):
		slots[1].select()
	elif event.is_action_pressed("Toolbar3"):
		slots[2].select()
	elif event.is_action_pressed("Toolbar4"):
		slots[3].select()
	elif event.is_action_pressed("Toolbar5"):
		slots[4].select()
	elif event.is_action_pressed("Toolbar6"):
		slots[5].select()

func _ready() -> void:
	for i in range(6):
		var slot := ToolSlot.new()
		slot.name = "ToolSlot"
		slot.texture = load("res://icon.svg")
		slot.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		slot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		slot.custom_minimum_size = slot_size
		slot.size = slot_size
		slot.position.x = i * (slot_size.x + slot_spacing)
		add_child(slot)
		slots.append(slot)
		
	custom_minimum_size.x = 8 * (slot_size.x + slot_spacing) - slot_spacing
	custom_minimum_size.y = slot_size.y
