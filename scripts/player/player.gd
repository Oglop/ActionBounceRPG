extends CharacterBody2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm = $FSM
@onready var leftCheck:RayCast2D = $LeftRayCast2D
@onready var rightCheck:RayCast2D = $RightRayCast2D
@onready var downcheck:RayCast2D = $DownRayCast2D
@onready var combatMarker:Marker2D = $CombatMarker2D
var f:functions = functions.new()

var _startPosition:Vector2i
var _downAttackBounce:float = 0
var _bounceStrength:float = 0
var _bounceWeak:float = 0
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
	fsm.change_state(Statics.STATE_IDLE)
	for n in range(Statics.TAIL_SIZE - 1, -1,-1):
		Data.playerPositions[n] = self.global_position
	for n in range(Statics.TAIL_SIZE - 1, -1,-1):
		Data.playerDirections[n] = direction
	
	

func _updateTrail() -> void:
	for n in range(Statics.TAIL_SIZE - 1, 0, -1):
		Data.playerPositions[n] = Data.playerPositions[n - 1]
	Data.playerPositions[0] = self.global_position
	
	for n in range(Statics.TAIL_SIZE - 1, 0, -1):
		Data.playerDirections[n] = Data.playerDirections[n - 1]
	Data.playerDirections[0] = direction
	
	
func _physics_process(delta: float) -> void:
	fsm.physics_update(delta)
	_checkforCollisions()
	_processBounce(delta)
	_resetBounce()
	_updateTrail()

func _checkforCollisions():
	var collider:Object
	if rightCheck.is_colliding() == true:
		_bouncingLeft = true
		collider = rightCheck.get_collider()
		
	elif leftCheck.is_colliding() == true:
		_bouncingRight = true
		collider = leftCheck.get_collider()
		
	if downcheck.is_colliding() == true && _downAttackBounce == 0:
		_isDownBouncing = true
		_downAttackBounce = 300
		
	if collider != null:
		if collider is Node && collider.is_in_group("enemy-small"):
			_handleCombat(collider)
			
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
	
	
func _handleCombat(collider:Node) -> bool:
	_bounceStrength = 100
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
		result = collider.applyDamage(5)	
	if collider.has_method("applyBounce"):
		result = collider.applyBounce(_getEnemyBounce(enemyToughness, critical))
	
	return true


func _getEnemyBounce(enemyToughness:int, critical:bool) -> int:
	var calculatedToughness:int = Data.toughness
	var diff:int = calculatedToughness - enemyToughness
	if critical:
		calculatedToughness += Statics.CRITICAL_BOUNCE_BONUS
		
	if diff <= Statics.BOUNCE_DIFF && diff  >= -Statics.BOUNCE_DIFF:
		_bounceStrength = Statics.MEDIUM_BOUNCE
		return Statics.MEDIUM_BOUNCE
		
	if diff > Statics.BOUNCE_DIFF:
		return Statics.BIG_BOUNCE
		
	return Statics.SMALL_BOUNCE
	
	
