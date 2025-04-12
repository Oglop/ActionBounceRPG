extends playerBaseState

func enter():
	play("walk")
	
	
func physics_process(delta: float) -> void:
	move(delta, false)

	if object.isJumpJustPressed():
		change_state(Statics.STATE_JUMP)
	elif !object.is_on_floor():
		change_state(Statics.STATE_FALL)
	elif object.getInputX()  == 0:
		change_state(Statics.STATE_IDLE)
