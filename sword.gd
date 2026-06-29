extends Node2D


@export var knockback = 300


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	$Area2D.monitoring = is_visible_in_tree()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.apply_knockback((Vector2.RIGHT * knockback).rotated(global_position.angle_to_point(body.global_position)))
