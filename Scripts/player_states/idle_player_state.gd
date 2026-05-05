class_name IdlePlayerState
extends BasePlayerState

func _enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "idle")

func _pre_update(player: Player) -> void:
	var direction := player._get_move_input()
	
	if not player.is_on_floor():
		player._change_state_to(PlayerStates.FALLING)
	#elif current_speed > player.run_speed:
		#player._change_state_to(PlayerStates.RUN)
	elif direction.length() > 0:
		player._change_state_to((PlayerStates.WALK))
	elif Input.is_action_just_pressed("ui_accept"):
		player._change_state_to(PlayerStates.JUMP)
