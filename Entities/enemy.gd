extends Entity
class_name Enemy


@export var damage = 10


func _ready() -> void:
	$ProgressBar.max_value = MAX_HEALTH


func _process(_delta: float) -> void:
	var player = get_parent().get_node("Player")
	if player:
		move_dir = (player.global_position - global_position).normalized()
	$ProgressBar.value = health


func _on_attack_box_body_entered(body: Node2D) -> void:
	if body is Player:
		body.health -= damage
