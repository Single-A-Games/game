extends Entity
class_name Enemy


func _process(_delta: float) -> void:
	move_dir = (get_parent().get_node("Player").global_position - global_position).normalized()
