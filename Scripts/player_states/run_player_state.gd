class_name RunPlayerState
extends BasePlayerState

## Called when we first enter this state.
func _enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "run")
	
func _pre_update(player: Player) -> void:
	var current_speed := player._get_current_speed()
	if current_speed == 0:
		player._change_state_to(PlayerStates.IDLE)
	if current_speed < player.run_speed:
		player._change_state_to(PlayerStates.WALK)
	
func _update(player: Player, delta: float) -> void:
	var direction := player._get_move_input()
	player._update_velocity_using_direction(direction)
	player.move_and_slide()
	player.turn_to(direction)
	var lean := direction.dot(player.global_basis.x)
	player.last_lean = lerpf(player.last_lean, lean, 0.3)
	player.anim_tree.set("parameters/run_lean/add_amount", player.last_lean)
	
