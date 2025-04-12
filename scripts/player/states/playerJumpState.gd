extends playerBaseState

func enter():
	object.velocity.y = - Statics.PLAYER_JUMP_STRENGTH_WEAK
	play("idle")


func physics_process(delta: float) -> void:
	move(delta, true)
	if object.velocity.y >= 0:
		change_state(Statics.STATE_FALL)
