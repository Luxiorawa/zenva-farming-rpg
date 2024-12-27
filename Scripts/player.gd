class_name Player
extends CharacterBody2D

var speed := 100

func _process(_delta: float) -> void:
	# On va gérer les mouvements dans la fonction _process plutôt que _input
	# car on cherche à perpétuer le mouvement si la touche est maintenu. La fonction _input
	# ne lit le mouvement QUE quand la touche est appuyé / relâché, et non pas continuellement 
	# (contrairement à _process qui s'exécute toute les frames)
	player_movement()

func player_movement() -> void:
	var input := Input.get_vector("Left", "Right", "Up", "Down")

	velocity = input.normalized() * speed

	move_and_slide()
