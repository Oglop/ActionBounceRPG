extends StaticBody2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
var f:functions
var _speed:float = 20.0
var _active:bool = true
var _minY:int = 0
var _maxY:int = 0
var _isGoingUp:bool = false
var _flipBlocked:bool = false


func _ready() -> void:
	f = functions.new()
	_isGoingUp = f.chance(50)

	
func setProperties(type:String, maxY:int, minY:int, isActiveCondition:String = "") -> void:
	if isActiveCondition != "":
		_active = false
		if Data.switches.has(isActiveCondition) && Data.switches[isActiveCondition] == true:
			_active = true
	_minY = minY
	_maxY = maxY
	sprite.play(type)
	
	
func _physics_process(delta: float) -> void:
	if _active:
		if _isGoingUp:
			global_position.y -= _speed * delta
		else:
			global_position.y += _speed * delta
			
		if global_position.y >= _maxY:
			_isGoingUp = true
		elif global_position.y <= _minY:
			_isGoingUp = false
		
