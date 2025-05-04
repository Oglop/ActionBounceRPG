extends Node2D

var _direction:int = 0
var f:functions = functions.new()

func _ready() -> void:
	await get_tree().create_timer(0.2).timeout
	queue_free()
	

func setProperteis(direction:int) -> void:
	_direction = direction
	if _direction < 0:
		scale.x = -1
		
	rotate(f.getRandomFloatInRange(0.7, 1.3))
