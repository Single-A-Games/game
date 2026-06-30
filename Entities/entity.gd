extends CharacterBody2D
class_name Entity


@export var SPEED = 50.0
@export var ACCELERATION = 300.0

@export var KNOCKBACK_DECELERATION = 1000

@export var MAX_HEALTH = 100

var move_dir := Vector2.ZERO
var knockback_stun := false

@onready var health = MAX_HEALTH


func _physics_process(delta: float) -> void:
	if knockback_stun:
		handle_knockback(delta)
	else:
		handle_movement(delta)
	
	if health <= 0:
		queue_free()


func handle_movement(delta: float) -> void:
	velocity = velocity.move_toward(move_dir * SPEED, ACCELERATION * delta)
	
	move_and_slide()


func handle_knockback(delta: float):
	if velocity.length_squared() == 0: 
		knockback_stun = false
		return
	
	velocity = velocity.move_toward(Vector2.ZERO, KNOCKBACK_DECELERATION * delta)
	
	move_and_slide()


func apply_knockback(knockback: Vector2):
	knockback_stun = true
	velocity = knockback
