extends Node2D


var timer = 0
var enemies := [
	preload("res://Entities/naomi_1.tscn"),
	preload("res://Entities/naomi_2.tscn"),
	preload("res://Entities/naomi_3.tscn"),
]


func _ready() -> void:
	pass #$AudioStreamPlayer.play()


func _process(delta: float) -> void:
	if timer <= 0:
		timer = randf_range(5, 15)
		spawn_enemy(4)
	
	timer -= delta


func spawn_enemy(num: int):
	for x in range(num):
		var new_enemy = enemies.pick_random().instantiate()
		add_child(new_enemy)
		new_enemy.position = Vector2(randf_range(-220, 220), randf_range(-220, 220))
