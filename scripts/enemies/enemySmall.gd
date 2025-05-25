extends CharacterBody2D


@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var collisionShape:CollisionShape2D = $CollisionShape2D
@onready var frontCheck:RayCast2D = $FrontRayCast2D
@onready var groundCheck:RayCast2D = $GroundRayCast2D
@onready var bullerSpawner:Marker2D = $BulletSpawnerMarker2D
@onready var flipTimer:Timer = $FlipTimer
@onready var hurtTimer:Timer = $HurtTimer
#@onready var enemyFsm = $enemyFsm

const DEBUG:bool = true

var f:functions = functions.new()

var _id:String
var _type:Enums.enemyType
var _name:String
var _maxHp:int = 0
var _hp:int = 0
var _toughness:int = 0
var _attack:int = 0
var _armor:int = 0
var _xpGain:int = 0
var _canShoot:String = "none"
var _speed:float = 0.0
var _shootCooldown:float = 9999999.0
var _shootBlock:float = 0
var _crownsGain:int = 0
var _hurtBlock:float = 0.2
var _bounceStrength:float = 0
var _bouncingLeft:bool = false
var _bouncingRight:bool = false
var _enemyState:Enums.enemyStates = Enums.enemyStates.IDLE
var _lastKnownPlayerPosition:Vector2
var _rangedAttack:int = 0

var direction:int = 0
var flipBlocked:bool = false
var hurtBlocked:bool = false

var knockback_duration: float = 0.2
var impactPosition:Vector2
var isKnockBack: bool = false
var knockBackTimer: float = 0.0


func _ready() -> void:
	Events.connect("PLAYER_MAKE_NOICE", _on_playerMakeNoice)
	direction = f.choose([1, -1])
	

func setProperties(name:String) -> void:
	var props = Data.enemyData[name]
	_id = f.generateObjectId()
	_type = Enums.stringToEnemyType(props["type"])
	_name = props["name"]
	_maxHp = props["hp"]
	_hp = _maxHp
	_speed = props["speed"]
	_toughness = props["toughness"]
	_attack = props["attack"]
	_armor = props["armor"]
	_xpGain = props["xp"]
	_crownsGain = props["crowns"]
	_hurtBlock = props["hurt-block"]
	_enemyState = Enums.stringToEnemyState(props["default-state"])
	if props.has("canShoot") && props.has("shootCooldown"):
		_canShoot = props["canShoot"]
		_shootCooldown = props["shootCooldown"]
		_rangedAttack = props["rangedAttack"]
	sprite.play(getAnimation(props["default-state"])) 

	
func getToughness() -> int:
	return _toughness + f.randomIntInRange(0,2)
	
	
func getAttack() -> int:
	return _attack + f.randomIntInRange(0,2)
	
	
func getArmor() -> int:
	return _armor
	
	
func _setFrontCheckerPositionAndDirection() -> void:
	if direction == 1:
		frontCheck.target_position = Vector2(12, 0)
	else:
		frontCheck.target_position = Vector2(-12, 0)
		

func _setGroundcheckPosition() -> void:
	if direction == 1:
		groundCheck.position = Vector2i(8,15)
	else:
		groundCheck.position = Vector2i(-8,15)
	
func applyDamage(value:int, critical:bool) -> void:
	if !hurtBlocked:
		Events.FX_DAMAGE_NUMBER.emit(global_position, value, critical, false, false)
		_hp = f.minusLimit(_hp, value, 0)
		print_debug("applyDamage _hp" + str(_hp) + " value: " + str(value))
		
		if _hp <= 0:
			_enemyState = Enums.enemyStates.DIE
			

func _blockHurt() -> void:
	hurtBlocked = true
	hurtTimer.start(0.8)
	

func applyBounce(value:int, playerPosition:Vector2) -> void:
	if !hurtBlocked:
		_blockHurt()
		impactPosition = playerPosition
		_bounceStrength = value
		_knockback(playerPosition, _bounceStrength)


func _physics_process(delta: float) -> void:
	if DEBUG && Input.is_action_just_pressed("btn_debug"):
		print_debug("DIRECTION: " + str(direction))
		print_debug("GROUND_CHECK.X: " + str(groundCheck.position.x) + ", Y:" + str(groundCheck.position.y))
		print_debug("FRONT_CHECK.X: " + str(frontCheck.position.x) + ", Y:" + str(frontCheck.position.y))
	_setFrontCheckerPositionAndDirection()
	_setGroundcheckPosition()
	#scale.x = direction
	
	if isKnockBack:
		knockBackTimer -= delta
		if knockBackTimer <= 0.0:
			isKnockBack = false
			velocity = Vector2.ZERO
	else:
		if _enemyState == Enums.enemyStates.IDLE:
			_doIdleState(delta)
		elif _enemyState == Enums.enemyStates.WALKING:
			_doWalkingState(delta)
		elif _enemyState == Enums.enemyStates.SHOOT:
			_doShootState(delta)
		elif _enemyState == Enums.enemyStates.DIE:
			_doDieState()
	# _bouncing()
	_applyGravity(delta)
	self.move_and_slide()
	sprite.flip_h = direction < 0
	_shootBlock -= delta * 1
	
	
func _doAirState() -> void:
	sprite.play(getAnimation("idle"))
	
	
func _doIdleState(delta:float) -> void:
	if isShootBlocked(delta):
		_flipToPlayer()
		sprite.play(getAnimation("idle"))
	
	if !isShootBlocked(delta) && _canShoot != null && _canShoot != "none":
		_enemyState = Enums.enemyStates.SHOOT
	
func _doShootState(delta:float) -> void:
	if !isShootBlocked(delta):
		sprite.play(getAnimation("shoot"))
		Events.ENEMY_SHOOT.emit(bullerSpawner.global_position, direction, _canShoot, _rangedAttack)
		_shootBlock = _shootCooldown * f.getRandomFloatInRange(0.8, 1.2)
		await get_tree().create_timer(0.4).timeout
		self._enemyState = Enums.enemyStates.IDLE
		
func isShootBlocked(delta:float) -> bool:
	if _shootBlock > 0.0:
		return true
	return false
	
	
func _doWalkingState(delta: float) -> void:
	sprite.play(getAnimation("walk"))
	_setGroundcheckPosition()
		
	if frontCheck.is_colliding() && !flipBlocked:
		_flip()
	if !groundCheck.is_colliding() && !flipBlocked:
		_flip()
	else:
		velocity.x = direction * _speed
	_checkFrontCheckPlayerInteraction()
	_move(delta, _speed)

func _knockback(impactPosition:Vector2, bounceStrength:float) -> void:
	var dir:Vector2 = (global_position - impactPosition).normalized()
	var bounce = dir * bounceStrength
	velocity = Vector2(bounce.x, 0.0)
	isKnockBack = true
	knockBackTimer = knockback_duration
	
func _doDieState() -> void:
	Events.ADD_XP.emit(_xpGain)
	Events.ENEMY_DESTROYED.emit(_id)
	Events.FX_EXPLOSION_SMALL.emit(global_position)

func _flip() -> void:
	direction *= -1
	flipBlocked = true
	flipTimer.start(0.2)
	#scale.x = direction
	
func _flipToPlayer() -> void:
	if _lastKnownPlayerPosition == null:
		return
	if _lastKnownPlayerPosition.x >= global_position.x && direction == -1:
		direction = 1

	elif _lastKnownPlayerPosition.x <= global_position.x && direction == 1:
		direction = -1
		
	flipBlocked = true
	flipTimer.start(0.2)
	

func _move(delta:float, speed:int) -> void:

	if _isBouncing():
		_knockback(impactPosition, _bounceStrength)
	else:
		_accelerate(delta)
		
		
func _checkFrontCheckPlayerInteraction() -> void:
	if frontCheck.is_colliding() == true:
		var collisionPosition:Vector2 = frontCheck.get_collision_point()
		var collider = frontCheck.get_collider()
		if collider is Node2D && collider.is_in_group("player"):
			if collider.has_method("applyNonCombatDamage"):
				collider.applyNonCombatDamage(_attack, global_position)
				
		

		
	
func _isBouncing() -> bool:
	return _bouncingLeft || _bouncingRight
	
func _applyGravity(delta) -> void:
	if !self.is_on_floor():
		var g = Statics.FALL_GRAVITY
		velocity.y = move_toward(velocity.y, Statics.TERMINAL_GRAVITY, g * delta)

func _accelerate(delta:float):
	velocity.x = move_toward(velocity.x, _speed * direction, Statics.PLAYER_ACCELERATION * delta)
	

func getAnimation(animation:String) -> String:
	var prefix:String = Enums.enemyTypeToString(_type)
	return prefix + "_" + animation
	

func _on_playerMakeNoice(playerPosition:Vector2) -> void:
	_lastKnownPlayerPosition = playerPosition
	if _enemyState == Enums.enemyStates.IDLE:
		_flipToPlayer()


func _on_flip_timer_timeout() -> void:
	flipBlocked = false


func _on_hurt_timer_timeout() -> void:
	hurtBlocked = false
