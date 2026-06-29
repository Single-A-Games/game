extends Entity
class_name Player


@onready var arm_tween: Tween


func _physics_process(delta: float) -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	handle_movement(delta)
	handle_actions(delta)


func handle_actions(_delta: float) -> void:
	var swing_degrees := 80.0
	
	if sin($Arm.rotation) < 0:
		$Arm.z_index = -1
	else:
		$Arm.z_index = 1
	
	if Input.is_action_just_pressed("primary_attack"):
		if arm_tween: return
		
		var ref_angle: float = rad_to_deg( global_position.angle_to_point(get_global_mouse_position()) )

		$Arm.rotation_degrees = ref_angle - swing_degrees / 2
		$Arm.show()
		arm_tween = create_tween()
		
		arm_tween.tween_property($Arm, "rotation_degrees", ref_angle + swing_degrees / 2, .25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		
		await arm_tween.finished
		
		arm_tween.kill()
		arm_tween = null
		$Arm.hide()
