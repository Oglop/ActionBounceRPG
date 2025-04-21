extends CharacterBody2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm = $FSM
@onready var leftCheck:RayCast2D = $LeftRayCast2D
@onready var rightCheck:RayCast2D = $RightRayCast2D
@onready var downcheck:RayCast2D = $DownRayCast2D
@onready var combatMarker:Marker2D = $CombatMarker2D
@onready var shield:AnimatedSprite2D = $Shield
@onready var sword:AnimatedSprite2D = $Sword
var f:functions = functions.new()
var s:skills = skills.new()


var _startPosition:Vector2i
var _downAttackBounce:float = 0
var _bounceStrength:float = 0
var _bouncingLeft:bool = false
var _bouncingRight:bool = false
var _isDownBouncing:bool = false

var direction:int :
	get: return direction
	set(value):
		if value == 0 or value == direction: return
		direction = value
		sprite.flip_h = value == -1


func setStartPosition(startPosition:Vector2i) -> void:
	_startPosition = startPosition



func _ready() -> void:
	Events.connect("PLAYER_MOVE_TO", _on_playerMoveTo)
	fsm.change_state(Statics.STATE_IDLE)
	for n in range(Statics.TAIL_SIZE - 1, -1,-1):
		Data.playerPositions[n] = self.global_position
	for n in range(Statics.TAIL_SIZE - 1, -1,-1):
		Data.playerDirections[n] = direction
	
func _on_playerMoveTo(position:Vector2i) -> void:
	global_position = position
	_updateTrail()
	

func _updateTrail() -> void:
	for n in range(Statics.TAIL_SIZE - 1, 0, -1):
		Data.playerPositions[n] = Data.playerPositions[n - 1]
	Data.playerPositions[0] = self.global_position
	
	for n in range(Statics.TAIL_SIZE - 1, 0, -1):
		Data.playerDirections[n] = Data.playerDirections[n - 1]
	Data.playerDirections[0] = direction
	
	
func _physics_process(delta: float) -> void:
	fsm.physics_update(delta)
	_setEnemyCheckerPositionAndDirection()
	_checkforCollisions()
	_processBounce(delta)
	_resetBounce()
	_updateTrail()
	_setSwordAndShieldPositionAndDirection()
	
	
func _setSwordAndShieldPositionAndDirection() -> void:
	if direction < 0:
		sword.scale.x = -1
		sword.position = Vector2(5, -1)
		shield.scale.x = -1
	else:
		sword.scale.x = 1
		sword.position = Vector2(-6, -1)
		shield.scale.x = 1
		
	
func _setEnemyCheckerPositionAndDirection() -> void:
	if direction == 0 || direction == null:
		rightCheck.target_position = Vector2(12 * 1, 0)
		return
	rightCheck.target_position = Vector2(12 * direction, 0)

func _checkforCollisions():
	var collider:Object
	var collisionPosition:Vector2
	if rightCheck.is_colliding() == true:
		collisionPosition = rightCheck.get_collision_point()
		_bouncingLeft = true
		collider = rightCheck.get_collider()
		
	if downcheck.is_colliding() == true && _downAttackBounce == 0:
		_isDownBouncing = true
		_downAttackBounce = 300
		
	if collider != null:
		if collisionPosition == null:
			collisionPosition = self.global_position
		if collider is Node && collider.is_in_group("enemy-small"):
			_handleCombat(collider, collisionPosition)
			
			
func _processBounce(delta):
	if !_bouncingLeft && !_bouncingRight:
		return
	
	if _bounceStrength > 0:
		_bounceStrength -= 20
	elif  _bounceStrength < 0:
		_bounceStrength += 20
	if _bouncingLeft:
		velocity = Vector2(_bounceStrength * -1, global_position.y)
		#velocity.x = move_toward(velocity.x, _bounceStrength * -1, delta)
	if _bouncingRight:
		velocity = Vector2(_bounceStrength, global_position.y)


func _resetBounce() -> void:
	if _bounceStrength == 0:
		_bouncingLeft = false
		_bouncingRight = false
	
	if _bouncingLeft && _bounceStrength > 0 || _bouncingRight && _bounceStrength < 0:
		_bounceStrength = 0
		_bouncingLeft = false
		_bouncingRight = false


func getInputX() -> float:
	return Input.get_axis("btn_left", "btn_right")
	
	
func isJumpJustPressed() -> bool:
	return Input.is_action_just_pressed("btn_jump")
	
	
func _handleCombat(collider:Node, collisionPoint:Vector2) -> bool:
	var critical:bool = f.chance(Data.critChance)
	var enemyToughness:int
	var enemyAttack:int
	var enemyArmor:int
	var result:int
	if collider.has_method("getToughness"):
		enemyToughness = collider.getToughness()
	if collider.has_method("getAttack"):
		enemyAttack = collider.getAttack()
	if collider.has_method("getArmor"):
		enemyArmor = collider.getArmor()
		
	if enemyArmor == null || enemyToughness == null || enemyAttack == null:
		return false
		
	if collider.has_method("applyDamage"):
		collider.applyDamage(_getAttack())
		Events.FX_WEAK_HIT.emit(combatMarker.global_position, direction)
	if collider.has_method("applyBounce"):
		var enemyBounceDirection:int = 1
		if collider.global_position.x > self.global_position.x:
			enemyBounceDirection = -1
		
		collider.applyBounce(_getEnemyBounce(enemyToughness, critical), enemyBounceDirection)
	
	return true


func _getEnemyBounce(enemyToughness:int, critical:bool) -> int:
	var calculatedToughness:int = Data.toughness
	var diff:int = calculatedToughness - enemyToughness
	if critical:
		calculatedToughness += Statics.CRITICAL_BOUNCE_BONUS
		
	if diff <= Statics.BOUNCE_DIFF && diff  >= -Statics.BOUNCE_DIFF:
		_bounceStrength = Statics.MEDIUM_BOUNCE
		return Statics.ENEMY_MEDIUM_BOUNCE
		
	if diff > Statics.BOUNCE_DIFF:
		_bounceStrength = Statics.SMALL_BOUNCE
		return Statics.ENEMY_BIG_BOUNCE
		
	_bounceStrength = Statics.BIG_BOUNCE
	return Statics.ENEMY_SMALL_BOUNCE
	
	
func _getAttack() -> int:
	return Data.lv + Data.strength
	
	
