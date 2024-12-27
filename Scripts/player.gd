class_name Player
extends CharacterBody2D

var speed := 100
var looking_left := true

@onready var sprite = $Sprite2D

func _process(_delta: float) -> void:
	# On va gérer les mouvements dans la fonction _process plutôt que _input
	# car on cherche à perpétuer le mouvement si la touche est maintenu. La fonction _input
	# ne lit le mouvement QUE quand la touche est appuyé / relâché, et non pas continuellement 
	# (contrairement à _process qui s'exécute toute les frames)
	player_movement()
	player_animation()

func player_animation() -> void:
	print(velocity.x)
	if velocity.x > 0 and looking_left:
		sprite.flip_h = true
		looking_left = false
	elif velocity.x < 0 and !looking_left:
		sprite.flip_h = false
		looking_left = true

func player_movement() -> void:
	var input := Input.get_vector("Left", "Right", "Up", "Down")

	velocity = input.normalized() * speed

	move_and_slide()
