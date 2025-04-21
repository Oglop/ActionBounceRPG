extends Node2D

#var previousRoom:Dictionary

var currentRoom:Dictionary
var currentRoomDoors:Array = []
var f:functions = functions.new()

func _ready() -> void:
	Events.connect("ROOM_LOAD", _on_roomLoadandMove)
	Events.connect("ROOM_CLEAR", _on_clearRoom)
	_on_roomLoadandMove("start")
	
	
func _on_roomLoadandMove(roomId:String) -> void:
	#previousRoom = currentRoom
	if currentRoom.size() > 0:
		_on_clearRoom(currentRoom.id)
	currentRoom = Data.roomData[roomId]
	
	for door in currentRoom["doors"]:
		var d = SceneLoader.getScene(Enums.spawnType.DOOR)
		add_child(d)
		d.global_position = Vector2(door.x, door.y)
		d.setProperties(door.id, door.connects, door.locked, Vector2i(door["connects-x"], door["connects-y"])) #setProperties(id:String, connects:String, locked:bool) -> void:
		currentRoomDoors.append(d)
		
		
func _on_clearRoom(roomId:String) -> void:
	for door:Node2D in currentRoomDoors:
		door.queue_free()
	currentRoomDoors = []
		
