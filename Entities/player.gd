extends Entity
class_name Player


@onready var arm_tween: Tween

var held_item = null


func _ready() -> void:
	$ProgressBar.max_value = MAX_HEALTH


func _physics_process(delta: float) -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	handle_movement(delta)
	handle_actions(delta)
	
	$ProgressBar.value = health
	
	if health <= 0:
		get_parent().get_node("Gui/CanvasLayer/GameOver").show()
		queue_free()


func handle_actions(_delta: float) -> void:
	held_item = $Arm/Hand.get_child(0)
	
	if Input.is_action_just_pressed("primary_attack") and held_item.is_ready():
		held_item.use($Arm, $ItemEffect)
