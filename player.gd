extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.003

# Get gravity from project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var neck = $Neck
@onready var camera = $Neck/Camera3D

func _ready():
	# Capture the mouse cursor inside the game window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	# Handle mouse look
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		neck.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		# Clamp vertical look so the player can't flip upside down
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Add the gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get WASD / Arrow keyboard inputs
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	# Rotate movement vectors relative to the neck direction
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
