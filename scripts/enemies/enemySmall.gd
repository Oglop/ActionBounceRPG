extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collisionShape = $CollisionShape2D
@onready var frontCheck = $FrontRayCast2D
@onready var groundCheck = $GroundRayCast2D
@onready var bullerSpawner = $BulletSpawnerMarker2D
@onready var flipTimer = $FlipTimer
@onready var enemyFsm = $enemyFsm

var _type:Enums.enemyType
var _maxHp:int
var _hp:int
var _toughness:int
var _attack:int
var _armor:int

var direction:int = -1
var flipBlocked:bool = false

func _ready() -> void:
	enemyFsm.change_state(Statics.STATE_ENEMY_WALK)
	
	
func setProperties(type:Enums.enemyType, startingPosition:Vector2i) -> void:
	_type = type
	_maxHp = 10
	_hp = 10
	_toughness = 10
	_attack = 12
	_armor = 1
	
func getToughness() -> int:
	return _toughness
	
func getAttack() -> int:
	return _attack
	
func getArmor() -> int:
	return _armor
	
func applyDamage(value:int) -> int:
	return 0

func applyBounce(value:int) -> void:
	enemyFsm.change_state("bounce")

func _physics_process(delta: float) -> void:
	enemyFsm.physics_update(delta)
	#var speed:int = 50
	#if !is_on_floor():
	#	velocity.y += Statics.GRAVITY * delta
	#	speed = 0
	
	#if direction == 1:
	#	groundCheck.position = Vector2i(15,15)
	#else:
	#	groundCheck.position = Vector2i(1,15)
	
	# if !groundCheck.is_colliding() && !flipBlocked:
	# 	sprite.flip_h = direction > 0
	# 	direction *= -1
	# 	flipBlocked = true
	# 	flipTimer.start(0.2)
		
	#else:
	#	velocity.x = direction * speed
	#move_and_slide()


func _on_flip_timer_timeout() -> void:
	flipBlocked = false
