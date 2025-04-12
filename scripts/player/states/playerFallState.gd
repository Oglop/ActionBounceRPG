extends playerBaseState

@onready var coyoteTimer = $CoyoteTimer

func enter():
	play("idle")
	if fsm.previous_state != "jump":
		coyoteTimer.start()

func physics_process(delta: float) -> void:
	move(delta, true)
	
	if !coyoteTimer.is_stopped() && object.isJumpJustPressed():
		change_state(Statics.STATE_JUMP)
	elif object.is_on_floor():
		if object.getInputX() == 0:
			change_state(Statics.STATE_IDLE)
		else:
			change_state(Statics.STATE_WALK)
