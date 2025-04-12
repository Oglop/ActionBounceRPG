extends enemyState
class_name enemyBaseState


func play(animation:String) -> void:
	object.sprite.play(getAnimation(animation))
	
	
func accelerate(delta:float, direction = object.getInputX()):
	var m:float = Statics.PLAYER_AIR_MULTIPLYER if not object.is_on_floor() else 1.0
	object.velocity.x = move_toward(object.velocity.x, Statics.PLAYER_SPEED_SLOW * direction, Statics.PLAYER_ACCELERATION * m * delta)


func applyGravity(delta) -> void:
	var g = Statics.FALL_GRAVITY
	object.velocity.y = move_toward(object.velocity.y, Statics.TERMINAL_GRAVITY, g * delta)

	
func move(delta:float, applyGravity:bool) -> void:
	var speed:int = 50
	if !object.is_on_floor():
		object.velocity.y += Statics.GRAVITY * delta
		speed = 0
	
	if object.direction == 1:
		object.groundCheck.position = Vector2i(15,15)
	else:
		object.groundCheck.position = Vector2i(1,15)
		
	if !object.groundCheck.is_colliding() && !object.flipBlocked:
		object.sprite.flip_h = object.direction > 0
		object.direction *= -1
		object.flipBlocked = true
		object.flipTimer.start(0.2)
	else:
		object.velocity.x = object.direction * 50
		
	# accelerate(delta, direction)
	if applyGravity: applyGravity(delta)
	#if updateDirection: object.direction = direction
	object.move_and_slide()


func getAnimation(animation:String) -> String:
	var prefix:String = Enums.enemyTypeToString(object._type)
	return prefix + "_" + animation
