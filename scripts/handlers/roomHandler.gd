extends Node2D

#var previousRoom:Dictionary

var currentRoom:Dictionary
var currentRoomDoors:Array = []
var currentRoomNPCs:Array = []
var currentRoomEnemies:Array = []
var currentRoomPlatforms:Array = []
var currentRoomTreasures:Array = []
var currentRoomSwitches:Array = []
var currentRoomTransitions:Array = []
var f:functions = functions.new()




func _ready() -> void:
	Events.connect("ROOM_LOAD", _on_roomLoadandMove)
	Events.connect("ROOM_CLEAR", _on_clearRoom)
	Events.connect("ENEMY_DESTROYED", _on_enemyDestroyed)
	Events.connect("PLATFORM_DESTROYED", _on_platformDestroyed)
	Events.connect("ROOM_SWITCH_FLIPPED", _on_switchFlipped)
	#_on_roomLoadandMove(Data.saveSpotRoomId)
	Events.ROOM_LOAD.emit(Data.saveSpotRoomId)
	Events.PLAYER_MOVE_TO.emit(Vector2i(Data.saveSpotX, Data.saveSpotY))

func _on_switchFlipped(id:String, onOff:bool) -> void:
	Data.switches[id] = onOff

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
	if currentRoom.has("area"):
		Events.EXPLORE_AREA.emit(currentRoom.area)
	
	Data.currentRoomId = roomId
	
	if currentRoom.has("doors"):
		for door in currentRoom["doors"]:
			var d = SceneLoader.getScene(Enums.spawnType.DOOR)
			add_child(d)
			d.global_position = Vector2(door.x, door.y)
			d.setProperties(door.id, door.connects, door.locked, Vector2i(door["connects-x"] + 8, door["connects-y"] + 8), door.type)
			currentRoomDoors.append(d)
		
	if currentRoom.has("npcs"):
		for npc in currentRoom["npcs"]:
			var addNpc:bool = true
			if npc.has("condition"):
				addNpc = solveConditionRule(npc.condition)
			if addNpc:
				var obj = SceneLoader.getScene(Enums.spawnType.NPC)
				add_child(obj)
				obj.global_position = Vector2i(npc["start-x"], npc["start-y"])
				obj.setProperties(npc.id)
				if npc.has("questStep"):
					obj.setPropertiesQuest(npc.questStep, npc.questNext)
					
				currentRoomNPCs.append(obj)
	
	if currentRoom.has("transitions"):
		for roomTrans in currentRoom["transitions"]:
			var obj = SceneLoader.getScene(Enums.spawnType.ROOM_TRANSÌTION)
			add_child(obj)
			obj.global_position = Vector2(roomTrans.x, roomTrans.y)
			obj.setProperties(roomTrans.id, roomTrans.horizontalCheck, roomTrans.connects, Vector2i(roomTrans["connects-x"] + 8, roomTrans["connects-y"] + 8))
			currentRoomTransitions.append(obj)
		
	if currentRoom.has("enemies"):
		for enemy in currentRoom["enemies"]:
			var obj = SceneLoader.getScene(Enums.spawnType.ENEMY_SMALL)
			add_child(obj)
			obj.global_position = Vector2i(enemy["start-x"], enemy["start-y"])
			obj.setProperties(enemy.name)
			currentRoomEnemies.append(obj)
		
	if currentRoom.has("platforms"):
		for platform in currentRoom["platforms"]:
			var platformType:Enums.spawnType = platformNameToSpawnType(platform.name)
			var obj = SceneLoader.getScene(platformType)
			add_child(obj)
			obj.global_position = Vector2i(platform["start-x"], platform["start-y"])
			if obj.has_method("setProperties") && platform.has("type"):
				if platformType == Enums.spawnType.ELEVATOR:
					var condition:String = ""
					if platform.has("isActiveCondition"):
						condition = platform.isActiveCondition
					obj.setProperties(platform.type, platform["max-y"], platform["min-y"], condition)
				elif platformType == Enums.spawnType.BOSS_DOOR:
					obj.setProperties(platform.bossid)
				else: #type:String, maxY:int, minY:int, isActiveCondition:String = ""
					obj.setProperties(platform.type)
					
			currentRoomPlatforms.append(obj)
		
	if currentRoom.has("treasures"):
		for treasure in currentRoom["treasures"]:
			var obj = SceneLoader.getScene(Enums.spawnType.TREASURE)
			add_child(obj)
			obj.global_position = Vector2i(treasure["start-x"], treasure["start-y"])
			obj.setProperties(treasure.id)
			currentRoomTreasures.append(obj)
		
	if currentRoom.has("switches"):
		for switch in currentRoom["switches"]:
			var obj = SceneLoader.getScene(Enums.spawnType.SWITCH)
			add_child(obj)
			obj.global_position = Vector2i(switch["start-x"], switch["start-y"])
			obj.setProperties(switch.id, switch.default, switch.flippable, switch.type)
			currentRoomSwitches.append(obj)
		
		
func _on_clearRoom(roomId:String) -> void:
	for d in currentRoomDoors:
		if is_instance_valid(d):
			d.queue_free()
	currentRoomDoors = []
	
	for n in currentRoomNPCs:
		if is_instance_valid(n):
			n.queue_free()
	currentRoomNPCs = []
	
	for e in currentRoomEnemies:
		if is_instance_valid(e):
			e.queue_free()
	currentRoomEnemies = []
	
	for p in currentRoomPlatforms:
		if is_instance_valid(p):
			p.queue_free()
	currentRoomPlatforms = []
	
	for t in currentRoomTreasures:
		if is_instance_valid(t):
			t.queue_free()
	currentRoomTreasures = []
	
	for s in currentRoomSwitches:
		if is_instance_valid(s):
			s.queue_free()
	currentRoomSwitches = []
	
	for tr in currentRoomTransitions:
		if is_instance_valid(tr):
			tr.queue_free()
	currentRoomTransitions = []
	
	
func solveConditionRule(condition:String) -> bool:
	var arr:Array = condition.split(";")
	var questline:String = arr[0]
	var operator:String = arr[1]
	var progress:int = int(arr[2])
	
	if !Data.quests.has(questline):
		Data.quests[questline] = 0
	
	if Data.quests.has(questline):
		if operator == "=":
			if progress == Data.quests[questline]:
				return true
		elif operator == "-":
			if progress >= Data.quests[questline]:
				return true
		elif operator == "+":
			if progress <= Data.quests[questline]:
				return true
	
	return false

func platformNameToSpawnType(name:String) -> Enums.spawnType:
	match name:
		Statics.PLATFORM_PUSHABLE_BLOCK: return Enums.spawnType.PUSHABLE_BLOCK
		Statics.PLATFORM_STAIRS: return Enums.spawnType.STAIRS
		Statics.PLATFORM_SAVE_SPOT: return Enums.spawnType.SAVE_SPOT
		Statics.PLATFORM_WINES_DISAPPEAR: return Enums.spawnType.WINES_DISAPPEAR
		Statics.PLATFORM_WINES_APPEAR: return Enums.spawnType.WINES_APPEAR
		Statics.PLATFORM_BREAKING_FLOOR: return Enums.spawnType.BREAKING_FLOOR
		Statics.PLATFORM_SPIKES: return Enums.spawnType.SPIKES
		Statics.PLATFORM_ELEVATOR: return Enums.spawnType.ELEVATOR
		Statics.PLATFORM_BOSS_DOOR: return Enums.spawnType.BOSS_DOOR
		_ : return Enums.spawnType.NONE
		
