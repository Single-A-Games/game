extends CharacterBody2D

const SPEED = 100.0
const MOVEMENT_ACCELERATION = 300.0

#@onready var camera = $Camera2D


func _physics_process(delta: float) -> void:
	handle_movement(delta)


func handle_movement(delta: float):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = velocity.move_toward(input_dir * SPEED, MOVEMENT_ACCELERATION * delta)

	move_and_slide()
