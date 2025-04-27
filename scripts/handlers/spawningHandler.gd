extends Node2D


func _ready() -> void:
	Events.connect("FX_WEAK_HIT", _on_fxWeakHit)
	Events.connect("FX_FIRE_BALL", _on_fxFireBall)
	Events.connect("FX_THIEF_KNIFE", _on_fxThiefKnife)
	
	
func _on_fxWeakHit(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_WEAK_HIT)
	fx.global_position = position
	self.add_child(fx)
	#if direction < 1:
	#	fx.scale = -1	


func _on_fxFireBall(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_FIRE_BALL)
	fx.global_position = position
	self.add_child(fx) 
	fx.setProperties(direction)
	
	
func _on_fxThiefKnife(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_THIEF_KNIFE)
	fx.global_position = position
	self.add_child(fx) 
	fx.setProperties(direction)
