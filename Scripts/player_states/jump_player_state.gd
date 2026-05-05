class_name JumpPlayerState
extends BasePlayerState

func _enter(player: Player) -> void:
	player.velocity.y = player.JUMP_VELOCITY
	
func _pre_update(player: Player) -> void:
	player._change_state_to(PlayerStates.FALLING)
