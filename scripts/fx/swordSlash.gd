extends Node2D

var _direction:int = 0
var f:functions = functions.new()
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	sprite.modulate.a = 0.6
	await get_tree().create_timer(0.3).timeout
	queue_free()
	

func setProperties(direction:int) -> void:
	_direction = direction
	if _direction < 0:
		scale.x = -1
		
	rotate(f.getRandomFloatInRange(-1.0, 1.0))
