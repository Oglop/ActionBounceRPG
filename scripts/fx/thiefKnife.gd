extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer

var _direction:int = 0
var _speed:float = 500
	
func setProperties(direction:int) -> void:
	_direction = direction

	timer.start(_getDuration())
	
	
func _physics_process(delta: float) -> void:
	global_position += Vector2(1,0) * _speed * delta * _direction
	
func _getDuration() -> float:
	return 0.3


func _on_timer_timeout() -> void:
	queue_free()
