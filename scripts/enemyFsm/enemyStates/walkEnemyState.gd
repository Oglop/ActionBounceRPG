extends enemyBaseState

func enter():
	play("walk")
	
# delta:float, applyGravity:bool
func physics_process(delta: float) -> void:
	move(delta, false)
