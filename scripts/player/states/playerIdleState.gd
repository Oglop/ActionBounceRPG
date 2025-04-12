extends playerBaseState

func enter():
	play("idle")


func physics_process(delta: float) -> void:
	move(delta, false)

	#if Input.is_action_just_pressed("btn_jump") && object.is_on_floor():
	if object.isJumpJustPressed():
		change_state(Statics.STATE_JUMP)
	elif !object.is_on_floor():
		change_state(Statics.STATE_FALL)
	elif object.getInputX() != 0:
		change_state(Statics.STATE_WALK)
