extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var marker = $Marker2D
@onready var groundcheck = $GroundArea2D

var _number:int
var _direction:int
var _type:Enums.tailType


func _ready() -> void:
	Events.connect("UPDATE_TAIL", _on_updateTail)
	Events.connect("REMOVE_TAIL", _on_removeTail)
	
	
func _physics_process(delta: float) -> void:
	var i:int = numberToTailPosition(_number)
	self.global_position = Data.playerPositions[i]
	_direction = Data.playerDirections[i]
	sprite.flip_h = _direction < 0
	sprite.play(_getAnimation(_type))
	
	
func setProperties(number:int, type:Enums.tailType) -> void:
	_number = number
	_type = type
	_direction = 1
	
func _on_updateTail() -> void:
	if _number == 1:
		_type = Data.tailNo1Type
	else:
		_type = Data.tailNo2Type
	
func _on_removeTail(slot:int) -> void:
	if _number == slot:
		queue_free()
	

func numberToTailPosition(number:int) -> int:
	if number == Statics.TAIL_POSITON_1:
		return Statics.TAIL_INDEX_1
	if number == Statics.TAIL_POSITON_2:
		return Statics.TAIL_INDEX_2
	return 39
	
func _getAnimation(tailType:Enums.tailType) -> String:
	var prefix:String = Enums.tailTypeToString(tailType)
	var postfix = _stateToAnimationString()
	return prefix + "_" + postfix
	
func _stateToAnimationString() -> String:
	if !isOnFloor():
		return "air"

	if Data.playerPositions[numberToTailPosition(_number)].x == global_position.x:
		return "idle"
	return "walk"
	
	
func isOnFloor() -> bool:
	if groundcheck.has_overlapping_bodies():
		return true
	return false
