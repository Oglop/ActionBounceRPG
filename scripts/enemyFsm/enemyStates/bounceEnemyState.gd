extends enemyBaseState


func enter() -> void:
	print_debug("enter bounce")


func physics_process(delta: float) -> void:
	if !object._bouncingLeft && !object._bouncingRight:
		change_state(Statics.STATE_ENEMY_IDLE)
	
	if object._bounceStrength > 0:
		object._bounceStrength -= 20
	elif  object._bounceStrength < 0:
		object._bounceStrength += 20
	if object._bouncingLeft:
		object.velocity = Vector2(object._bounceStrength * -1, object.global_position.y)
		object.direction = -1
	if object._bouncingRight:
		object.velocity = Vector2(object._bounceStrength, object.global_position.y)
		object.direction = 1
		
	var leftRight = "" 
	if object._bouncingLeft: 
		leftRight = "left"
	elif object._bouncingRight:
		leftRight = "right"
		
	print_debug("bounce " + leftRight + " with strength: " + str(object._bounceStrength))

	move(delta, true)
	
	if object._bounceStrength == 0:
		object._bouncingLeft = false
		object._bouncingRight = false
		change_state(Statics.STATE_ENEMY_IDLE)
	
	if object._bouncingLeft && object._bounceStrength < 0 || object._bouncingRight && object._bounceStrength > 0:
		object._bounceStrength = 0
		object._bouncingLeft = false
		object._bouncingRight = false
		change_state(Statics.STATE_ENEMY_IDLE)
		
