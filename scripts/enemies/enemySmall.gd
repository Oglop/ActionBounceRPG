extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collisionShape = $CollisionShape2D
@onready var frontCheck = $FrontRayCast2D
@onready var groundCheck = $GroundRayCast2D
@onready var bullerSpawner = $BulletSpawnerMarker2D
@onready var flipTimer = $FlipTimer
@onready var hurtTimer = $HurtTimer
@onready var enemyFsm = $enemyFsm
var enemyStats:enemyStatsBase = enemyStatsBase.new()
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
var _crownsGain:int = 0
var _hurtBlock:float = 0.2
var _bounceStrength:float = 0
var _bouncingLeft:bool = false
var _bouncingRight:bool = false

var direction:int = -1
var flipBlocked:bool = false
var hurtBlocked:bool = false


func _ready() -> void:
	pass
	

func setProperties(name:String) -> void:
	var props = Data.enemyData[name]
	_id = f.generateObjectId()
	_type = Enums.stringToEnemyType(props["type"])
	_name = props["name"]
	_maxHp = props["hp"]
	_hp = _maxHp
	_toughness = props["toughness"]
	_attack = props["attack"]
	_armor = props["armor"]
	_xpGain = props["xp"]
	_crownsGain = props["crowns"]
	_hurtBlock = props["hurt-block"]
	enemyFsm.change_state(props["default-state"])

	
func getToughness() -> int:
	return _toughness + f.randomIntInRange(0,2)
	
	
func getAttack() -> int:
	return _attack + f.randomIntInRange(0,2)
	
	
func getArmor() -> int:
	return _armor
	
	
func applyDamage(value:int) -> void:
	if !hurtBlocked:
		
		_hp = f.minusLimit(_hp, value, 0)
		print_debug("applyDamage _hp" + str(_hp) + " value: " + str(value))
		if _hp <= 0:
			enemyFsm.change_state(Statics.STATE_ENEMY_DIE)
			

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
		enemyFsm.change_state(Statics.STATE_ENEMY_BOUNCE)

func _physics_process(delta: float) -> void:
	enemyFsm.physics_update(delta)


func _on_flip_timer_timeout() -> void:
	flipBlocked = false


func _on_hurt_timer_timeout() -> void:
	hurtBlocked = false
