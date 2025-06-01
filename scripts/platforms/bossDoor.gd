extends StaticBody2D

var _bossId:String

func _ready() -> void:
	Events.connect("BOSS_DEFEATED", _on_bossDefeated)
	
	

func _physics_process(delta: float) -> void:
	if destroyIfBossDefeated(_bossId):
		doorBreaking()
	
	
func _on_bossDefeated(bossId:String) -> void:
	if bossId == _bossId:
		doorBreaking()
	
func doorBreaking() -> void:
	var upper:Vector2 = Vector2(global_position.x + 8, global_position.y + 8)
	var lower:Vector2 = Vector2(global_position.x + 8, global_position.y + 24)
	Events.FX_BLOCK_BREAKING.emit(upper)
	Events.FX_BLOCK_BREAKING.emit(lower)
	queue_free()
	
func setProperties(bossId:String) -> void:
	_bossId = bossId
	

func destroyIfBossDefeated(bossId:String) -> bool:
	match bossId:
		Statics.BOSS_TREE_CENTIPEDE: return Data.bossCentipedeDefeated
	
	return false
