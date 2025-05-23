extends CharacterBody2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm = $FSM
@onready var rightCheck:RayCast2D = $RightRayCast2D
@onready var downcheck:RayCast2D = $DownRayCast2D
@onready var combatMarker:Marker2D = $CombatMarker2D
@onready var shield:AnimatedSprite2D = $Shield
@onready var sword:AnimatedSprite2D = $Sword
@onready var comboTimer:Timer = $ComboTimer
@onready var hurtBox:Area2D = $HurtBoxArea2D
var f:functions = functions.new()
var s:skills = skills.new()


var _startPosition:Vector2i
var _downAttackBounce:float = 0
var _bounceStrength:float = 0
var _bouncingLeft:bool = false
var _bouncingRight:bool = false
var _isDownBouncing:bool = false
var _staminaRegenerationInterval:float = 0.4
var _attackNumber:int = 0
var _jumpBlocked:bool = false

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
	Events.connect("PLAYER_JUMP_BLOCK", _on_jumpBlock)
	Events.connect("PLAYERS_UPDATE_EQUIPMENT", _on_playerUpdateEquipment)
	Events.connect("PLAYER_STEPPED_ON_SPIKES", _on_steppedOnSpikes)
	fsm.change_state(Statics.STATE_IDLE)
	for n in range(Statics.TAIL_SIZE - 1, -1,-1):
		Data.playerPositions[n] = self.global_position
	for n in range(Statics.TAIL_SIZE - 1, -1,-1):
		Data.playerDirections[n] = direction
	_setSwordAnimation()
	_setShieldAnimation()
	
func _on_playerMoveTo(position:Vector2i) -> void:
	global_position = position
	_updateTrail()
	Events.PLAYER_MAKE_NOICE.emit(global_position)
	

func _on_playerUpdateEquipment() -> void:	
	_setSwordAnimation()
	_setShieldAnimation()

func _on_steppedOnSpikes(position:Vector2) -> void:
	applyNonCombatDamage(10, position, true)

func _updateTrail() -> void:
	for n in range(Statics.TAIL_SIZE - 1, 0, -1):
		Data.playerPositions[n] = Data.playerPositions[n - 1]
	Data.playerPositions[0] = self.global_position
	
	for n in range(Statics.TAIL_SIZE - 1, 0, -1):
		Data.playerDirections[n] = Data.playerDirections[n - 1]
	Data.playerDirections[0] = direction
	
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("btn_pause"):
		Events.ROOM_SHOW_PAUSE_MENU.emit()
	
	fsm.physics_update(delta)
	_setEnemyCheckerPositionAndDirection()
	_checkforCollisions()
	_processBounce(delta)
	_resetBounce()
	_updateTrail()
	_setSwordAndShieldPositionAndDirection()
	
	if comboTimer.is_stopped():
		if Data.staminaCurrent < Data.staminaMax:
			Events.ADD_STAMINA.emit(1)
			comboTimer.start(_staminaRegenerationInterval)
		
	
func _setSwordAnimation() -> void:
	if !Data.weapon == Enums.weapons.NONE:
		if !sword.visible:
			sword.visible = true
		if Data.weapon == Enums.weapons.SHORT:
			sword.play("short")
		if Data.weapon == Enums.weapons.KNIGHT:
			sword.play("knight")
		if Data.weapon == Enums.weapons.SLAYER:
			sword.play("slayer")
	else:
		sword.visible = false

	
func _setShieldAnimation() -> void:
	if !Data.shield == Enums.shields.NONE:
		if !shield.visible:
			shield.visible = true
		if Data.shield == Enums.shields.ROUND:
			shield.play("round")
		if Data.shield == Enums.shields.KNIGHT:
			shield.play("knight")
		if Data.shield == Enums.shields.MAGIC:
			shield.play("magic")
	else:
		shield.visible = false
	
func _setSwordAndShieldPositionAndDirection() -> void:
	if direction < 0:
		sword.scale.x = -1
		sword.position = Vector2(5, -1)
		shield.scale.x = -1
		combatMarker.position = Vector2(-14, 2)
	else:
		sword.scale.x = 1
		sword.position = Vector2(-6, -1)
		shield.scale.x = 1
		combatMarker.position = Vector2(14, 2)
		
	
func _setEnemyCheckerPositionAndDirection() -> void:
	if direction == 0 || direction == null:
		rightCheck.target_position = Vector2(12 * 1, 0)
		return
	rightCheck.target_position = Vector2(12 * direction, 0)

func applyNonCombatDamage(dmg:int, impactPoint:Vector2, isFloorDamage:bool = false) -> void:
	Events.RECEIVE_DAMAGE.emit(dmg)
	

func _applyPlayerBounce(collisionPosition:Vector2) -> void:
	if collisionPosition.x > global_position.x:
		_bouncingLeft = true
	else:
		_bouncingRight = true
	

func _checkforCollisions():
	var collider:Object
	var collisionPosition:Vector2
	if rightCheck.is_colliding() == true:
		collisionPosition = rightCheck.get_collision_point()
		_applyPlayerBounce(collisionPosition)
		collider = rightCheck.get_collider()
		
	#if downcheck.is_colliding():# && _downAttackBounce == 0:
	#	_checkBreakingFloor()
		#_isDownBouncing = true
		#_downAttackBounce = 300
		
	if collider != null:
		if collisionPosition == null:
			collisionPosition = self.global_position
		if collider is Node && collider.is_in_group("enemy-small"):
			_handleCombat(collider, collisionPosition)
			
	var bodies = hurtBox.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemy-bullet"):
			_handleEnemyBulletCollision(body)
			
			
func _handleEnemyBulletCollision(bullet:CharacterBody2D) -> void:
	if bullet.has_method("getProperties"):
		var receiveDamage:bool = true
		if canBlockBullet(bullet._type):
			if bullet._direction != direction:
				receiveDamage = false
				Events.PLAY_SOUND_EFFECT.emit(Statics.SFX_PLAYER_BLOCK_BULLET)
			if (direction == 1 && global_position.x < bullet.global_position.x) || (direction == -1 && global_position.x > bullet.global_position.x):
				receiveDamage = false
				Events.PLAY_SOUND_EFFECT.emit(Statics.SFX_PLAYER_BLOCK_BULLET)
		if receiveDamage:
			applyNonCombatDamage(bullet._attack, bullet.global_position)
		bullet.queue_free()
			
#func _checkBreakingFloor() -> void:
#	var collider:Node2D = downcheck.get_collider()
#	if collider.is_in_group("breaking-floor") && collider.has_method("breakFloor"):
#		collider.breakFloor()
			
			
func canBlockBullet(type:String) -> bool:
	if is_on_floor():
		match type:
			"weak": return s.canBlockWeakBullets
			"medium": return s.canBlockMediumBullets
			"strong": return s.canBlockStrongBullets
	return false
			
func _processBounce(delta):
	# var dir:Vector2 = (global_position - impactPosition).normalized()
	# var bounce = dir * bounceStrength
	# velocity = Vector2(bounce.x, 0.0)
	# isKnockBack = true
	# knockBackTimer = knockback_duration
	
	if !_bouncingLeft && !_bouncingRight:
		return
	
	if _bounceStrength > 0:
		_bounceStrength -= 20
	elif  _bounceStrength < 0:
		_bounceStrength += 20
	if _bouncingLeft:
		velocity = Vector2(_bounceStrength * -1, 0.0)
	if _bouncingRight:
		velocity = Vector2(_bounceStrength, 0.0)
	Events.PLAYER_MAKE_NOICE.emit(global_position)


func _resetBounce() -> void:
	if _bounceStrength == 0:
		_bouncingLeft = false
		_bouncingRight = false
	
	if _bouncingLeft && _bounceStrength > 0:
		_bounceStrength = 0
		_bouncingLeft = false
		_bouncingRight = false
	if _bouncingRight && _bounceStrength < 0:
		_bounceStrength = 0
		_bouncingLeft = false
		_bouncingRight = false

func getInputX() -> float:
	return Input.get_axis("btn_left", "btn_right")
	
	
func isJumpJustPressed() -> bool:
	if !_jumpBlocked:
		return Input.is_action_just_pressed("btn_jump")
	return false
	
	
func _checkEnemyBulletCollision() -> void:
	var bodies = self.get
	
	
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
		if critical:
			Events.CAMERA_SHAKE.emit(4, 0.3)
		collider.applyDamage(_getAttack(critical))
		Events.FX_SWORD_ATTACK.emit(combatMarker.global_position, direction, _attackNumber)
		Events.PLAY_SOUND_EFFECT.emit(Statics.SFX_PLAYER_BOUNCE)
		comboTimer.start(0.3)
		if _attackNumber == 0:
			_attackNumber = 1
	var enemtDamageMultiplyer:float = f.getRandomFloatInRange(0.8, 1.2)
	var damage = int(enemyAttack * enemtDamageMultiplyer)
	if damage > 0:
		Events.RECEIVE_DAMAGE.emit(damage)
	
	if collider.has_method("applyBounce"):
		var enemyBounceDirection:int = 1
		if collider.global_position.x > self.global_position.x:
			enemyBounceDirection = -1
		
		collider.applyBounce(_getEnemyBounce(enemyToughness, critical), global_position)
	
	return true
	
	
func _tailTypeToGlobalPosition(type:Enums.tailType) -> Vector2:
	if Data.tailNo1Type == type:
		return Data.playerPositions[Statics.TAIL_INDEX_1]
	else:
		return Data.playerPositions[Statics.TAIL_INDEX_2]

func tailDamageBonus() -> int:
	var bonus:int = 0
	if s.canCastFireBalls:
		if Data.staminaCurrent >= Statics.SKILL_FIRBALL_COST:
			Events.SUB_STAMINA.emit(Statics.SKILL_FIRBALL_COST)
			bonus += Data.fireballDamage()
			Events.FX_FIRE_BALL.emit(_tailTypeToGlobalPosition(Enums.tailType.WIZARD), direction)
	if s.canThrowThiefKnife:
		if Data.staminaCurrent >= Statics.SKILL_THIEF_KNIFE_COST:
			Events.SUB_STAMINA.emit(Statics.SKILL_THIEF_KNIFE_COST)
			bonus += Data.thiefknifeDamage()
			Events.FX_THIEF_KNIFE.emit(_tailTypeToGlobalPosition(Enums.tailType.THIEF), direction) 
	if s.canShootArrow:
		if Data.staminaCurrent >= Statics.SKILL_ELF_ARROW_COST:
			Events.SUB_STAMINA.emit(Statics.SKILL_ELF_ARROW_COST)
			bonus += Data.elfArrowDamage()
			Events.FX_ELF_ARROW.emit(_tailTypeToGlobalPosition(Enums.tailType.ELF), direction) 
	return bonus


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
	
	
func _getAttack(critical:bool) -> int:
	var attack = Data.attack + tailDamageBonus()
	if critical:
		attack += attack * Statics.PLAYER_CRITICAL_MULTIPLYER
	return attack
	
	
func _on_jumpBlock() -> void:
	_jumpBlocked = true
	await get_tree().create_timer(0.3).timeout
	_jumpBlocked = false


func _on_combo_timer_timeout() -> void:
	comboTimer.stop()
	
