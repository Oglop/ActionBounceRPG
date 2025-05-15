extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D
var _speed:float = 100
var _direction:int = 0
var _type:String = ""
var _lifeTime:float = 0


func _ready() -> void:
	pass

	
func _physics_process(delta):
	global_position += Vector2(1,0) * _speed * delta * _direction


func setProperties(type:String, direction:int) -> void:
	_direction = direction
	_type = type
	_speed = getSpeed()
	_lifeTime = getLifetime()
	await get_tree().create_timer(_lifeTime).timeout
	queue_free()
	

func getSpeed() -> float:
	return Data.enemyData.bullets[_type].speed

	
func getLifetime() -> float:
	return Data.enemyData.bullets[_type].duration
	
	
