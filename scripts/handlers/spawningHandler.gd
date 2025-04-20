extends Node2D


func _ready() -> void:
	Events.connect("FX_WEAK_HIT", _on_fxWeakHit)
	
	
	
func _on_fxWeakHit(position:Vector2, direction:int) -> void:
	var fx = SceneLoader.getScene(Enums.spawnType.FX_WEAK_HIT)
	fx.global_position = position
	self.add_child(fx)
	#if direction < 1:
	#	fx.scale = -1	
