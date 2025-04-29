extends enemyBaseState


func enter() -> void:
	pass


func physics_process(delta: float) -> void:
	if !object._bouncingLeft && !object._bouncingRight:
		change_state(Statics.STATE_ENEMY_WALK)
	
	if object._bounceStrength > 0:
		object._bounceStrength -= 20
	elif  object._bounceStrength < 0:
		object._bounceStrength += 20
	if object._bouncingLeft:
		object.direction = -1
	if object._bouncingRight:
		object.direction = 1
		
	object.velocity.x = object.direction * object._bounceStrength
	
	if applyGravity: applyGravity(delta)
	
	object.move_and_slide()
		
	if object._bounceStrength == 0:
		object._bouncingLeft = false
		object._bouncingRight = false
		change_state(Statics.STATE_ENEMY_WALK)
	
	if object._bouncingLeft && object._bounceStrength < 0 || object._bouncingRight && object._bounceStrength > 0:
		object._bounceStrength = 0
		object._bouncingLeft = false
		object._bouncingRight = false
		change_state(Statics.STATE_ENEMY_WALK)
		
