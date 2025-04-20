extends Node2D

@onready var fx = $CPUParticles2D

func _ready() -> void:
	
	fx.emitting = true
	
func _on_cpu_particles_2d_finished() -> void:
	queue_free()
