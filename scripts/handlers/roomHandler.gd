extends Node2D

#var previousRoom:Dictionary

var currentRoom:Dictionary
var currentRoomDoors:Array = []
var currentRoomNPCs:Array = []
var currentRoomEnemies:Array = []
var currentRoomPlatforms:Array = []
var f:functions = functions.new()




func _ready() -> void:
	Events.connect("ROOM_LOAD", _on_roomLoadandMove)
	Events.connect("ROOM_CLEAR", _on_clearRoom)
	Events.connect("ENEMY_DESTROYED", _on_enemyDestroyed)
	Events.connect("PLATFORM_DESTROYED", _on_platformDestroyed)
	_on_roomLoadandMove("start")


func _on_enemyDestroyed(id:String) -> void:
	var index:int = -1

	for i in range(0,currentRoomEnemies.size()):
		if currentRoomEnemies[i]._id == id:
			index = i
			break
	if index != -1 && currentRoomEnemies.size() > index: 
		var enemy:Node2D = currentRoomEnemies.pop_at(index)
		enemy.queue_free()
	
	
func _on_platformDestroyed(id:String) -> void:
	var index:int = -1

	for i in range(0,currentRoomPlatforms.size()):
		if currentRoomPlatforms[i]._id == id:
			index = i
			break
	if index != -1 && currentRoomPlatforms.size() > index: 
		var pf:Node2D = currentRoomPlatforms.pop_at(index)
		pf.queue_free()
	
	
func _on_roomLoadandMove(roomId:String) -> void:
	#previousRoom = currentRoom
	if currentRoom.size() > 0:
		_on_clearRoom(currentRoom.id)
	currentRoom = Data.roomData[roomId]
	
	for door in currentRoom["doors"]:
		var d = SceneLoader.getScene(Enums.spawnType.DOOR)
		add_child(d)
		d.global_position = Vector2(door.x, door.y)
		d.setProperties(door.id, door.connects, door.locked, Vector2i(door["connects-x"] + 8, door["connects-y"] + 8))
		currentRoomDoors.append(d)
		
	for npc in currentRoom["npcs"]:
		var obj = SceneLoader.getScene(Enums.spawnType.NPC)
		add_child(obj)
		obj.global_position = Vector2i(npc["start-x"], npc["start-y"])
		obj.setProperties(npc.id)
		currentRoomNPCs.append(obj)
		
	for enemy in currentRoom["enemies"]:
		var obj = SceneLoader.getScene(Enums.spawnType.ENEMY_SMALL)
		add_child(obj)
		obj.global_position = Vector2i(enemy["start-x"], enemy["start-y"])
		obj.setProperties(enemy.name)
		currentRoomEnemies.append(obj)
		
	for platform in currentRoom["platforms"]:
		var platformType:Enums.spawnType = platformNameToSpawnType(platform.name)
		var obj = SceneLoader.getScene(platformType)
		add_child(obj)
		obj.global_position = Vector2i(platform["start-x"], platform["start-y"])
		#obj.setProperties(platform.name)
		currentRoomPlatforms.append(obj)
		
		
func _on_clearRoom(roomId:String) -> void:
	for door:Node2D in currentRoomDoors:
		door.queue_free()
	currentRoomDoors = []
	
	for npc:Node2D in currentRoomNPCs:
		npc.queue_free()
	currentRoomNPCs = []
	
	for obj:Node2D in currentRoomEnemies:
		obj.queue_free()
	currentRoomEnemies = []
	
	for obj:Node2D in currentRoomPlatforms:
		obj.queue_free()
	currentRoomPlatforms = []
	

func platformNameToSpawnType(name:String) -> Enums.spawnType:
	match name:
		Statics.PLATFORM_PUSHABLE_BLOCK: return Enums.spawnType.PUSHABLE_BLOCK
		Statics.PLATFORM_STAIRS: return Enums.spawnType.STAIRS
		_ : return Enums.spawnType.NONE
		
