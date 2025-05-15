extends Node2D


func _ready() -> void:
	Events.connect("FX_WEAK_HIT", _on_fxWeakHit)
	Events.connect("FX_FIRE_BALL", _on_fxFireBall)
	Events.connect("FX_THIEF_KNIFE", _on_fxThiefKnife)
	Events.connect("FX_ELF_ARROW", _on_fxElfArrow)
	Events.connect("FX_SWORD_ATTACK", _on_swordAttack)
	Events.connect("FX_SWORD_SLASH", _on_swordSlash)
	Events.connect("FX_HIT_GROUND_DUST", _on_hitGroundDust)
	Events.connect("ENEMY_SHOOT", _on_enemyShoot)
	Events.connect("FX_EXPLOSION_SMALL", _on_explosionSmall)
	
func _on_explosionSmall(position:Vector2) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_EXPLOSION_SMALL)
	fx.global_position = position
	self.add_child(fx)

	
func _on_swordSlash(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_SWORD_SLASH)
	fx.global_position = position
	self.add_child(fx)
	fx.setProperties(direction)
	
func _on_hitGroundDust(position:Vector2) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_GROUND_HIT_DUST)
	fx.global_position = position
	self.add_child(fx)
	
func _on_fxWeakHit(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_WEAK_HIT)
	fx.global_position = position
	self.add_child(fx)
	#if direction < 1:
	#	fx.scale = -1	
func _on_enemyShoot(position:Vector2, direction:int, type:String) -> void:
	var bullet = SceneLoader.getScene(Enums.spawnType.ENEMY_BULLET)
	bullet.global_position = position
	self.add_child(bullet)
	bullet.setProperties(type, direction)


func _on_fxFireBall(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_FIRE_BALL)
	fx.global_position = position
	self.add_child(fx) 
	fx.setProperties(direction)
	
	
func _on_fxElfArrow(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_ELF_ARROW)
	fx.global_position = position
	self.add_child(fx) 
	fx.setProperties(direction)
	
func _on_fxThiefKnife(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_THIEF_KNIFE)
	fx.global_position = position
	self.add_child(fx) 
	fx.setProperties(direction)
	
func _on_swordAttack(position:Vector2, direction:int, combo:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_SWORD_ATTACK)
	fx.global_position = position
	self.add_child(fx) 
	fx.setProperties(direction, combo) 
