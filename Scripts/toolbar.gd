class_name ToolBar
extends Control

@export var slot_size := Vector2(64, 64)
@export var slot_spacing := 4
@export var tool_slot_scene: PackedScene

var slots: Array[ToolSlot] = []
var default_slots_img: Array[String] = ["./../Assets/Sprites/Items/water-bucket.png"]
var current_selected_slot: ToolSlot

func _input(event: InputEvent) -> void:
	for i in range(6):
		if event.is_action_pressed("Toolbar" + str(i + 1)):
			if current_selected_slot:
				current_selected_slot.deselect()

			current_selected_slot = slots[i]
			current_selected_slot.select()

func _ready() -> void:
	for i in range(6):
		var slot: ToolSlot = tool_slot_scene.instantiate()
		slot.name = "ToolSlot" + str(i + 1)
		if i < default_slots_img.size() and default_slots_img[i]:
			slot.texture = load(default_slots_img[i])
		slot.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		slot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		slot.configure_size(slot_size)
		slot.position.x = i * (slot_size.x + slot_spacing)
		add_child(slot)
		slots.append(slot)
		
	custom_minimum_size.x = 8 * (slot_size.x + slot_spacing) - slot_spacing
	custom_minimum_size.y = slot_size.y
