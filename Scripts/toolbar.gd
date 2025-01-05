class_name ToolBar
extends Control

@export var slot_size := Vector2(64, 64)
@export var slot_spacing := 4
@export var tool_slot_scene: PackedScene

var slots: Array[ToolSlot] = []
var default_slots_img: Array[String] = ["./../Assets/Sprites/Items/water-bucket.png"]
var current_selected_slot: ToolSlot

@onready var world = get_node("/root/World")

func _input(event: InputEvent) -> void:
	for i in slots.size():
		if event.is_action_pressed("Toolbar" + str(i + 1)):
			if current_selected_slot:
				current_selected_slot.deselect()

			current_selected_slot = slots[i]
			current_selected_slot.select()
			print("Changed farming_mode_state to", current_selected_slot.tool_index)
			world.farming_mode_state = current_selected_slot.tool_index

func _ready() -> void:
	var available_tools: Dictionary = world.TOOLS_CONFIG
 
	for tool_mode in available_tools:
		var slot: ToolSlot = tool_slot_scene.instantiate()
		var config = available_tools[tool_mode]

		# Configuration du slot
		slot.name = config["name"]
		slot.tool_index = tool_mode as World.farming_modes
		if config["sprite"]:
			slot.texture = load(config["sprite"])
			
		slot.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		slot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		slot.configure_size(slot_size)
		slot.position.x = slots.size() * (slot_size.x + slot_spacing)

		add_child(slot)
		slots.append(slot)
		
	custom_minimum_size.x = 8 * (slot_size.x + slot_spacing) - slot_spacing
	custom_minimum_size.y = slot_size.y
