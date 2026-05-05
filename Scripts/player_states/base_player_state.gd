class_name BasePlayerState
extends RefCounted

## Called when we first enter this state.
func _enter(player: Player) -> void:
	pass
	
## Called when we exit a state.
func _exit(player: Player) -> void:
	pass
	
## Called before update is called, alows for state changes
func _pre_update(player: Player) -> void:
	pass

## Called for every phsics frame that we're in this state.
func _update(player: Player, delta: float) -> void:
	pass
