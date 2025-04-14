extends enemyBaseState


func enter() -> void:
	pass


func physics_process(delta: float) -> void:
	object.direction = 0
	move(delta, true)
