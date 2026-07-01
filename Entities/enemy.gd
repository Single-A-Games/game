extends Entity
class_name Enemy


@export var attack_damage = 10
@export var attack_knockback = 200


func _ready() -> void:
	$ProgressBar.max_value = MAX_HEALTH
	$AnimatedSprite2D.play()


func _process(_delta: float) -> void:
	if get_parent().has_node("Player"):
		var player = get_parent().get_node("Player")
		move_dir = (player.global_position - global_position).normalized()
	$ProgressBar.value = health


func _on_attack_box_body_entered(body: Node2D) -> void:
	if body is Player:
		body.damage(attack_damage, (body.global_position - global_position).normalized() * attack_knockback)
