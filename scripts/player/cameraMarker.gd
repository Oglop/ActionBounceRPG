extends Marker2D

@onready var player = get_node("../Player")
var cameraType:Enums.cameraType = Enums.cameraType.FREE

func _ready() -> void:
	Events.connect("PLAYER_MOVE_TO", _on_playerMoveTo)
	Events.connect("ROOM_LOAD", _on_roomLoad)

func _physics_process(delta: float) -> void:
	if player != null:
		if cameraType == Enums.cameraType.FREE:
			global_position = player.global_position
		if cameraType == Enums.cameraType.HORI:
			global_position.x = player.global_position.x
		if cameraType == Enums.cameraType.VERT:
			global_position.y = player.global_position.y

func _on_roomLoad(roomId:String) -> void:
	cameraType = Enums.stringToCameraType(Data.roomData[roomId].camera) 
	

func _on_playerMoveTo(position:Vector2) -> void:
	global_position = position
	
	
