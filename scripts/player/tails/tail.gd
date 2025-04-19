extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var marker = $Marker2D
@onready var groundcheck = $GroundArea2D

var _number:int
var _direction:int
var _type:Enums.tailType
var _previousPosition:Vector2


func _ready() -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	var i:int = numberToTailPosition(_number)
	self.global_position = Data.playerPositions[i]
	_direction = Data.playerDirections[i]
	sprite.flip_h = _direction < 0
	sprite.play(_getAnimation(_type))
	_previousPosition = global_position
	
	
	
func setProperties(number:int, type:Enums.tailType) -> void:
	_number = number
	_type = type
	_direction = 1
	

func numberToTailPosition(number:int) -> int:
	if number == 1:
		return 8
	if number == 2:
		return 16
	return 39
	
func _getAnimation(tailType:Enums.tailType) -> String:
	var prefix:String = Enums.tailTypeToString(tailType)
	var postfix = _stateToAnimationString()
	return prefix + "_" + postfix
	
func _stateToAnimationString() -> String:
	if !isOnFloor():
		return "air"
	if _previousPosition.x == global_position.x:
		return "idle"
	return "walk"
	
	
func isOnFloor() -> bool:
	if groundcheck.has_overlapping_bodies():
		return true
	return false
