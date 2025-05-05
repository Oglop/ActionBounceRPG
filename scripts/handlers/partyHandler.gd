extends Node2D

var _test:int = 0

func _on_initTail() -> void:
	if Data.tailNo1Type != Enums.tailType.NONE:
		var tail1 = SceneLoader.getScene(Enums.spawnType.TAIL)
		self.add_child(tail1)
		tail1.setProperties(1, Data.tailNo1Type)
	if Data.tailNo2Type != Enums.tailType.NONE:
		var tail2 = SceneLoader.getScene(Enums.spawnType.TAIL)
		self.add_child(tail2)
		tail2.setProperties(2, Data.tailNo2Type)



func _ready() -> void:
	Events.connect("INIT_TAIL", _on_initTail)
	Events.connect("SYNC_TAIL", _on_syncTail)
	Events.DATA_LOAD_SLOT.emit(Data.saveSlot)
	Events.PLAYER_MOVE_TO.emit(Vector2i(Data.saveSpotX, Data.saveSpotY))
	_on_syncTail()
	
	
	
func _on_syncTail() -> void:
	Events.REMOVE_TAIL.emit(1)
	Events.REMOVE_TAIL.emit(2)
	
	if Data.tailNo1Type != Enums.tailType.NONE:
		var tail1 = SceneLoader.getScene(Enums.spawnType.TAIL)
		self.add_child(tail1)
		tail1.setProperties(1, Data.tailNo1Type)
	
		
		
	if Data.tailNo2Type != Enums.tailType.NONE:
		var tail2 = SceneLoader.getScene(Enums.spawnType.TAIL)
		self.add_child(tail2)
		tail2.setProperties(2, Data.tailNo2Type)
	
		
	

			
			
