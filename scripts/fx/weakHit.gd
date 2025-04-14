extends Node2D

@onready var fx = $CPUParticles2D

func _ready() -> void:

	fx.emitting = true
	queue_free()


	
