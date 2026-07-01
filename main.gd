extends Node2D


var enemies := [
	preload("res://Entities/naomi_1.tscn"),
	preload("res://Entities/naomi_2.tscn"),
	preload("res://Entities/naomi_3.tscn"),
]

var game_active = false
var timer = 20


func _ready() -> void:
	$Gui/CanvasLayer/MainMenu/VBoxContainer/StartButton.connect("pressed", func(): game_active = true)


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
