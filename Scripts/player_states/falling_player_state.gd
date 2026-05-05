class_name FallingPlayerState
extends BasePlayerState

func _enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "fall")

func _pre_update(player: Player) -> void:
	if player.is_on_floor():
		player._change_state_to(PlayerStates.IDLE)

func _update(player: Player, delta: float) -> void:
	var direction := player._get_move_input()
	player.velocity += player.get_gravity() * delta
	player._update_velocity_using_direction(direction, player.base_speed * 0.25)
	player.move_and_slide()
	player.turn_to(direction)
