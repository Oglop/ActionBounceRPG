extends enemyBaseState



func enter() -> void:
	Events.ADD_XP.emit(object._xpGain)
	Events.ENEMY_DESTROYED.emit(object._id)

func physics_process(delta: float) -> void:
	pass
