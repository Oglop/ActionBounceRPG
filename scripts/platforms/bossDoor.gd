extends StaticBody2D

var _bossId:String

func _ready() -> void:
	Events.connect("BOSS_DEFEATED", _on_bossDefeated)
	
	

func _physics_process(delta: float) -> void:
	if destroyIfBossDefeated(_bossId):
		queue_free()
	
	
func _on_bossDefeated(bossId:String) -> void:
	if bossId == _bossId:
		queue_free()
	
	
func setProperties(bossId:String) -> void:
	_bossId = bossId
	

func destroyIfBossDefeated(bossId:String) -> bool:
	match bossId:
		Statics.BOSS_TREE_CENTIPEDE: return Data.bossCentipedeDefeated
	
	return false
