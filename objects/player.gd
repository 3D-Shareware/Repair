extends CharacterBody3D

@onready var camera_pivot = $"Camera Pivot"
@onready var camera = $"Camera Pivot/Camera3D"
@onready var raycast = $"Camera Pivot/Camera3D/Block Finder Raycast"

@onready var block_placer = $"Camera Pivot/Camera3D/Block Placer"
@onready var block_breaker = $"Camera Pivot/Camera3D/Block Breaker"

var game: Node3D

## Should be set to different tiles dependent on the target build.
var build_tile = 1

var take_inputs = false

const MOUSE_SENSITIVITY = 0.005

const GRAV = -40.0
const JUMP_HEIGHT = 14.0
const GROUND_ACCEL = 60.0
const MAX_SPEED = 10.0

# the number of projects I have made where the y velocity is overriden manually every frame is truly ridiculous
var current_grav = 0.0

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		var camera_movement: Vector2
		camera_movement = event.screen_relative * -MOUSE_SENSITIVITY
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x + camera_movement.y, -PI / 2, PI / 2)
		camera_pivot.rotate_y(camera_movement.x)

func _ready() -> void:
	take_inputs = true
	game = get_parent().get_parent()

func _physics_process(delta: float) -> void:
	# *** Camera movement ***
	var cam_rot = camera_pivot.global_rotation.y
	
	# *** Jumping and gravity ***
	if is_on_floor():
		if Input.is_action_pressed("kevincraft_jump"):
			current_grav = JUMP_HEIGHT
		else:
			current_grav = 0.0
	elif is_on_ceiling() and current_grav > 0:
		current_grav = 0
	else:
		current_grav += GRAV * delta
	
	# *** Horizontal movement ***
	var raw_input_dir = Input.get_vector("kevincraft_left", "kevincraft_right", "kevincraft_down", "kevincraft_up")
	
	# modified by raw_input based on camera rotation
	var cooked_input_dir = Vector3.ZERO
	
	# forward and back
	cooked_input_dir.z -= raw_input_dir.y * cos(cam_rot)
	cooked_input_dir.x -= raw_input_dir.y * sin(cam_rot)
	# left and right
	cooked_input_dir.z -= raw_input_dir.x * sin(cam_rot)
	cooked_input_dir.x += raw_input_dir.x * cos(cam_rot)
	
	velocity = velocity.move_toward(cooked_input_dir * MAX_SPEED, GROUND_ACCEL * delta)
	velocity.y = current_grav
	
	# update raycast
	if raycast.is_colliding():
		block_placer.position.z = -camera_pivot.global_position.distance_to(raycast.get_collision_point()) + 0.05
		block_breaker.position.z = -camera_pivot.global_position.distance_to(raycast.get_collision_point()) - 0.05
	else:
		block_placer.position.z = -10
		block_breaker.position.z = -10
	if game != null:
		game.center_placement_indicator(block_placer.global_position, raycast.get_collision_normal(), raycast.is_colliding())
	
	if take_inputs:
		if Input.is_action_just_pressed("kevincraft_place") and raycast.is_colliding():
			if game != null:
				var placing_position: Vector3 = block_placer.global_position
				# converts placing position into tile position
				var tile_position: Vector3i = game.return_tile_pos(placing_position)
				# builds tile
				game.build_tile(Vector3i(tile_position.x, tile_position.y, tile_position.z), build_tile)
		if Input.is_action_just_pressed("kevincraft_break") and raycast.is_colliding():
			if game != null:
				var breaking_position: Vector3 = block_breaker.global_position
				# converts breaking position into tile position
				var tile_position: Vector3i = game.return_tile_pos(breaking_position)
				# breaks tile
				game.break_tile(Vector3i(tile_position.x, tile_position.y, tile_position.z), false)
	
	move_and_slide()

func disable_block_inputs():
	take_inputs = false
	# prevents player from entering out of bounds area and losing twice
	collision_layer = 0

func disable_player():
	camera.current = false
	disable_block_inputs()
