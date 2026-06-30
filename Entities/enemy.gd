extends Entity
class_name Enemy


func _ready() -> void:
	$ProgressBar.max_value = MAX_HEALTH


func _process(_delta: float) -> void:
	move_dir = (get_parent().get_node("Player").global_position - global_position).normalized()
	$ProgressBar.value = health
