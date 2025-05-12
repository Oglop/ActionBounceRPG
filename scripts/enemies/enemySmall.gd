extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collisionShape = $CollisionShape2D
@onready var frontCheck = $FrontRayCast2D
@onready var groundCheck = $GroundRayCast2D
@onready var bullerSpawner = $BulletSpawnerMarker2D
@onready var flipTimer = $FlipTimer
@onready var hurtTimer = $HurtTimer
#@onready var enemyFsm = $enemyFsm

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
var _crownsGain:int = 0
var _hurtBlock:float = 0.2
var _bounceStrength:float = 0
var _bouncingLeft:bool = false
var _bouncingRight:bool = false
var _enemyState:Enums.enemyStates = Enums.enemyStates.IDLE

var direction:int = 0
var flipBlocked:bool = false
var hurtBlocked:bool = false


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
	sprite.play(getAnimation(props["default-state"])) 

	
func getToughness() -> int:
	return _toughness + f.randomIntInRange(0,2)
	
	
func getAttack() -> int:
	return _attack + f.randomIntInRange(0,2)
	
	
func getArmor() -> int:
	return _armor
	

	
func _setFrontCheckerPositionAndDirection() -> void:
	if direction == 0 || direction == null:
		frontCheck.target_position = Vector2(12 * 1, 0)
		return
	frontCheck.target_position = Vector2(12 * direction, 0)
	
	
func applyDamage(value:int) -> void:
	if !hurtBlocked:
		
		_hp = f.minusLimit(_hp, value, 0)
		print_debug("applyDamage _hp" + str(_hp) + " value: " + str(value))
		if _hp <= 0:
			_enemyState = Enums.enemyStates.DIE
			

func _blockHurt() -> void:
	hurtBlocked = true
	hurtTimer.start(0.8)
	

func applyBounce(value:int, direction:int) -> void:
	if !hurtBlocked:
		_blockHurt()
		_bounceStrength = value
		if direction < 0:
			_bouncingRight = true
		else:
			_bouncingLeft = true


func _physics_process(delta: float) -> void:
	scale.x = direction
		
	_setFrontCheckerPositionAndDirection()
	if _enemyState == Enums.enemyStates.IDLE:
		_doIdleState()
	elif _enemyState == Enums.enemyStates.WALKING:
		_doWalkingState(delta)
	elif _enemyState == Enums.enemyStates.SHOOT:
		_doShootState()
	elif _enemyState == Enums.enemyStates.DIE:
		_doDieState()
	# _bouncing()
	_applyGravity(delta)
	self.move_and_slide()
	
func _doAirState() -> void:
	sprite.play(getAnimation("idle"))
	
	
func _doIdleState() -> void:
	sprite.play(getAnimation("idle"))
	if _canShoot != null && _canShoot != "none":
		var wait = f.getRandomFloatInRange(0.8, 1.2)
		await get_tree().create_timer(_shootCooldown * wait)
		self._enemyState == Enums.enemyStates.SHOOT
	
	
func _doWalkingState(delta: float) -> void:
	sprite.play(getAnimation("walk"))
	if direction == 1:
		groundCheck.position = Vector2i(8,15)
	else:
		groundCheck.position = Vector2i(-8,15)
		
	if frontCheck.is_colliding() && !flipBlocked:
		_flip()
		flipBlocked = true
		flipTimer.start(0.2)
	if !groundCheck.is_colliding() && !flipBlocked:
		_flip()
		flipBlocked = true
		flipTimer.start(0.2)
	else:
		velocity.x = direction * _speed
		
	_move(delta, _speed)

func _bouncing() -> void:
	if _bounceStrength > 0:
		_bounceStrength -= 20
	elif  _bounceStrength < 0:
		_bounceStrength += 20
	if _bouncingLeft:
		direction = -1
	if _bouncingRight:
		direction = 1
		
	velocity.x = direction * _bounceStrength

func _doShootState() -> void:
	Events.ENEMY_SHOOT.emit(global_position, direction, _canShoot)
	sprite.play(getAnimation("shoot"))
	await get_tree().create_timer(0.8).timeout
	self._enemyState == Enums.enemyStates.IDLE


func _doDieState() -> void:
	Events.ADD_XP.emit(_xpGain)
	Events.ENEMY_DESTROYED.emit(_id)

func _flip() -> void:
	direction *= -1
	scale.x = direction
	
func _flipTo(playerPosition:Vector2) -> void:
	if playerPosition.x >= global_position.x && direction == -1:
		direction = 1

	elif playerPosition.x <= global_position.x && direction == 1:
		direction = -1

	

func _move(delta:float, speed:int) -> void:
	#self.velocity.x += direction * speed * delta
	_accelerate(delta)
	#_bouncing()
	#self.move_and_slide()
	
	
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
	if _enemyState == Enums.enemyStates.IDLE:
		_flipTo(playerPosition)


func _on_flip_timer_timeout() -> void:
	flipBlocked = false


func _on_hurt_timer_timeout() -> void:
	hurtBlocked = false
