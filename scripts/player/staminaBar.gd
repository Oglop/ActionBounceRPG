extends ProgressBar

func _ready() -> void:
	Data.staminaMax = 20
	Data.staminaCurrent = 16

func _physics_process(delta: float) -> void:
	size.x = Data.staminaMax
	min_value = 0
	max_value = Data.staminaMax
	value = Data.staminaCurrent
