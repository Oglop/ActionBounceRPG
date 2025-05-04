extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D
var _speed:float = 4
var _direction:int = 0
var _type:String = ""


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	queue_free()

	
func _physics_process(delta):
	var flipped:bool = _direction < 0
	sprite.flip_h = flipped
	if !flipped:
		velocity.x = _speed
	else:
		velocity.x = -_speed
	self.set_velocity(velocity)
	#self.set_up_direction(Vector2.UP)
	self.move_and_slide()
	self.velocity


func setProperties(type:String, direction:int) -> void:
	_direction = direction
	_type = type
