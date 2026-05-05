class_name Player
extends CharacterBody3D
@onready var animation_player: AnimationPlayer = $Mesh/AnimationPlayer
@onready var anim_tree: AnimationTree = $AnimationTree
var last_lean := 0.0


@export var base_speed := 5.0
const JUMP_VELOCITY = 4.5
@onready var camera: Node3D = $SpringArm3D/Camera3D

## Speed that the player is condered "running".
var run_speed := 3.5

## Default speed used to blend animations.
const BLEND_SPEED := 0.2

## The current state that our player is in.
var state: BasePlayerState = PlayerStates.IDLE

func _ready() -> void:
	state._enter(self)

## Changes the current player state and runs the correct functions.
func _change_state_to(next_state: BasePlayerState) -> void:
	state._exit(self)
	state = next_state
	state._enter(self)

func _physics_process(delta: float) -> void:
	state._pre_update(self)
	state._update(self, delta)

func turn_to(direction: Vector3) -> void:
	if direction:
		var yaw := atan2(-direction.x, -direction.z)
		yaw = lerp_angle(rotation.y, yaw, .25)
		rotation.y = yaw
		
## Reads the direciton movement input for the player, adjusts it based
## on the camera, and returns it.
func _get_move_input() -> Vector3:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (camera.global_basis * Vector3(input_dir.x, 0, input_dir.y))
	direction = Vector3(direction.x, 0, direction.z).normalized() * input_dir.length()
	return direction
	
## Returns the player's current speed
func _get_current_speed() -> float:
	return velocity.length()
	
## Applies velocity baed on directional movement input.
func _update_velocity_using_direction(direction: Vector3, speed: float = base_speed) -> void:
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
