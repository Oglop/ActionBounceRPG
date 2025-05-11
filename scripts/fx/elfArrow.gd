extends Node2D

@onready var sprite = $AnimatedSprite2D

var _direction:int = 0
var _speed:float = 300

func _ready() -> void:
	await get_tree().create_timer(0.4).timeout
	queue_free()
	
	
func setProperties(direction:int) -> void:
	_direction = direction
	
	
func _physics_process(delta: float) -> void:
	global_position += Vector2(1,0) * _speed * delta * _direction
