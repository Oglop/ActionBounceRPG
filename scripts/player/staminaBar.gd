extends ProgressBar


func _physics_process(delta: float) -> void:
	value = (Data.staminaMax / 100) * Data.staminaCurrent
