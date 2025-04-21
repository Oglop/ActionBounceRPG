extends StaticBody2D

@onready var floorCheck:Area2D = $AreaFloor
@onready var rightCheck:Area2D = $AreaRight
@onready var leftCheck:Area2D = $AreaLeft
var s:skills = skills.new()

enum _states {
	STOPPED,
	FALLING,
	PUSHED_RIGHT,
	PUSHED_LEFT,
}

var _state:_states = _states.STOPPED
var _beingPushedLeft:int = 0
var _beingPushedRight:int = 0

func _physics_process(delta: float) -> void:
	#_checkForFallingState(delta)
	_checkForPushingBlock()
	_movePushedBlock(delta)

func _movePushedBlock(delta:float) -> void:
	if _beingPushedRight > 10 && _beingPushedRight <= 20:
		global_position.x += 20 * delta
	elif _beingPushedRight > 20:
		global_position.x += 40 * delta
		
	if _beingPushedLeft > 10 && _beingPushedLeft <= 20:
		global_position.x -= 20 * delta
	elif _beingPushedLeft > 20:
		global_position.x -= 40 * delta
	
func _checkForFallingState(delta:float) -> void:
	var collides:bool = isCollidingWithBodies(floorCheck)
	if collides && _state == _states.FALLING:
		_state = _states.STOPPED
		return
	
	if !collides:
		_state = _states.FALLING
		global_position.y += 50 * delta
		
	
	
func _checkForPushingBlock() -> void:
	if !s.canPushBlocks:
		return
		
	if _state == _states.FALLING:
		return

		
	if _state == _states.STOPPED:
		#push right
		if Input.is_action_pressed("btn_right"):
			if isBeingPushed(leftCheck) && !isCollidingWithBodies(rightCheck):
				print("push from right" + str(_beingPushedRight))
				_beingPushedRight += 1
				_beingPushedLeft = 0
				if _beingPushedRight >= 100:
					_beingPushedRight = 100
			else:
				_beingPushedRight = 0
		else:
			_beingPushedRight = 0
			
		#puch left
		if Input.is_action_pressed("btn_left"):
			if isBeingPushed(rightCheck) && !isCollidingWithBodies(leftCheck):
				print("push from left" + str(_beingPushedLeft))
				_beingPushedLeft += 1
				_beingPushedRight = 0
				if _beingPushedLeft >= 100:
					_beingPushedLeft = 100
			else:
				_beingPushedLeft = 0
		else:
			_beingPushedLeft = 0
		

func isCollidingWithArea(area:Area2D) -> bool:
	var areas = area.get_overlapping_areas()
	for a in areas:
		return true
	return false
	
func isCollidingWithBodies(area:Area2D) -> bool:
	var bodies = area.get_overlapping_bodies()
	for b in bodies:
		return true
	return false
	
	
func isBeingPushed(area:Area2D) -> bool:
	var bodies = area.get_overlapping_bodies()
	for b in bodies:
		if b.is_in_group("player"):
			return true
	return false
