extends Node2D


@export var damage = 25
@export var knockback = 300
@export var cooldown := .75
@export var swing_degrees := 150.0
@export var slash := preload("res://assets/art/sword slash (2).png")

var arm_tween: Tween
var cooldown_timer := 0.0

var hit_targets := []
var arm: Node2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	$Area2D.monitoring = is_visible_in_tree()
	cooldown_timer = max(0, cooldown_timer - delta)
	if arm:
		arm.z_index = sign(sin(arm.rotation))


func use(_arm: Node2D, item_effect: Sprite2D) -> void:
	arm = _arm
	hit_targets = []
	cooldown_timer = cooldown
	
	if arm_tween: return
	
	var ref_angle: float = global_position.angle_to_point(get_global_mouse_position())
	var offset = deg_to_rad(swing_degrees) / 2 * sign(cos(ref_angle))
	
	arm.rotation = ref_angle - offset
	
	arm.show()
	arm_tween = create_tween()
	
	arm_tween.tween_property(arm, "rotation", ref_angle + offset, .3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	arm_tween.tween_interval(.1)
	
	await get_tree().create_timer(.1).timeout
	
	item_effect.rotation = ref_angle
	item_effect.modulate.a = .5
	item_effect.texture = slash
	
	await arm_tween.finished
	
	arm_tween.kill()
	arm_tween = null
	
	arm.hide()
	arm = null
	
	item_effect.rotation = 0
	item_effect.modulate.a = 1
	item_effect.texture = null


func is_ready() -> bool:
	return cooldown_timer == 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy and body not in hit_targets:
		hit_targets.append(body)
		body.apply_knockback((Vector2.RIGHT * knockback).rotated(global_position.angle_to_point(body.global_position)))
		body.health -= damage
