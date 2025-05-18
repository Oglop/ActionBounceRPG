extends Node2D

@onready var area:Area2D = $Area2D

func _physics_process(delta: float) -> void:
	for body:Node2D in area.get_overlapping_bodies():
		if body.is_in_group("player"):
			Events.PLAYER_STEPPED_ON_SPIKES.emit(global_position)
			
