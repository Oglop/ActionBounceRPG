extends enemyBaseState

func enter() -> void:
	Events.ENEMY_SHOOT.emit(object.global_position, object.direction, "weak")
	play("shoot")
	await get_tree().create_timer(0.8).timeout
	change_state(Statics.STATE_ENEMY_IDLE)

func physics_process(delta: float) -> void:
	pass 
