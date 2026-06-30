extends Node2D


var timer = 10
var enemy = preload("res://Entities/enemy.tscn")


func _ready() -> void:
	pass #$AudioStreamPlayer.play()


func _process(delta: float) -> void:
	if timer <= 0:
		timer = randf_range(5, 15)
		for x in range(4):
			var new_enemy = enemy.instantiate()
			add_child(new_enemy)
			new_enemy.position = Vector2(randf_range(-280, 280), randf_range(-280, 280))
	
	timer -= delta
