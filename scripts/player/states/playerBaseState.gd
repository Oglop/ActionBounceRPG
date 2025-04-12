extends state
class_name playerBaseState

func play(animation:String) -> void:
	object.sprite.play(animation)
	
func accelerate(delta:float, direction = object.getInputX()):
	var m:float = Statics.PLAYER_AIR_MULTIPLYER if not object.is_on_floor() else 1.0
	object.velocity.x = move_toward(object.velocity.x, Statics.PLAYER_SPEED_SLOW * direction, Statics.PLAYER_ACCELERATION * m * delta)

func applyGravity(delta) -> void:
	var g = Statics.JUMP_GRAVITY if fsm.current_state == Statics.STATE_JUMP else Statics.FALL_GRAVITY
	object.velocity.y = move_toward(object.velocity.y, Statics.TERMINAL_GRAVITY, g * delta)

func move(delta:float, applyGravity:bool, updateDirection:bool = true, direction = object.getInputX()) -> void:
	accelerate(delta, direction)
	if applyGravity: applyGravity(delta)
	if updateDirection: object.direction = direction
	object.move_and_slide()
		
	
