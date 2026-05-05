class_name WalkPlayerState
extends BasePlayerState

func _enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "walk")
	
func _pre_update(player: Player) -> void:
	var current_speed := player._get_current_speed()
	if current_speed == 0:
		player._change_state_to(PlayerStates.IDLE)
	elif current_speed > player.run_speed:
		player._change_state_to(PlayerStates.RUN)
	
func _update(player: Player, delta: float) -> void:
	var direction := player._get_move_input()
	player._update_velocity_using_direction(direction)
	player.move_and_slide()
	player.turn_to(direction)
	var walk_speed := lerpf(0.5, 1.75, player._get_current_speed()/player.run_speed)
	player.anim_tree.set("parameters/walk_speed/scale", walk_speed)
