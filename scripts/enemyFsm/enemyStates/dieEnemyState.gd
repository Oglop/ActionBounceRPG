extends enemyBaseState

func enter() -> void:
	Events.ADD_XP.emit(object._xpGain)


func physics_process(delta: float) -> void:
	object.queue_free()
