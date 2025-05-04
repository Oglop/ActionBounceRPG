extends Marker2D

@onready var player = get_node("../Player")
var cameraType:Enums.cameraType = Enums.cameraType.FREE
var minX:int = 0
var minY:int = 0
var maxX:int = 0
var maxY:int = 0
const noBorder:int = -999999


func _ready() -> void:
	Events.connect("PLAYER_MOVE_TO", _on_playerMoveTo)
	Events.connect("ROOM_LOAD", _on_roomLoad)


func _physics_process(delta: float) -> void:
	if player != null:
		if cameraType == Enums.cameraType.FREE:
			global_position = player.global_position
		if cameraType == Enums.cameraType.HORI:
			if player.global_position.x > minX && player.global_position.x < maxX:
				global_position.x = player.global_position.x
		if cameraType == Enums.cameraType.VERT:
			if player.global_position.y > minY && player.global_position.y < maxY:
				global_position.y = player.global_position.y
			
		if cameraType != Enums.cameraType.STILL:
			if minX != noBorder && global_position.x < minX:
				global_position.x = minX
			if maxX != noBorder && global_position.x > maxX:
				global_position.x = maxX
			if minY != noBorder && global_position.y < minY:
				global_position.y = minY
			if maxY != noBorder && global_position.y > maxY:
				global_position.y = maxY


func _on_roomLoad(roomId:String) -> void:
	cameraType = Enums.stringToCameraType(Data.roomData[roomId].camera)
	
	if Data.roomData[roomId].has("min-x"):
		minX = Data.roomData[roomId]["min-x"]
	else:
		minX = noBorder
		
	if Data.roomData[roomId].has("min-y"):
		minY = Data.roomData[roomId]["min-y"]
	else:
		minY = noBorder
	
	if Data.roomData[roomId].has("max-x"):
		maxX = Data.roomData[roomId]["max-x"]
	else:
		maxX = noBorder
	
	if Data.roomData[roomId].has("max-y"):
		maxY = Data.roomData[roomId]["max-y"]
	else:
		maxY = noBorder	
		
	if cameraType == Enums.cameraType.HORI && minY != noBorder:
		global_position.y = minY
	if cameraType == Enums.cameraType.VERT && minX != noBorder:
		global_position.x = minX


func _on_playerMoveTo(position:Vector2) -> void:
	global_position = position
	
	
