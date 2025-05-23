extends Area2D

@onready var hori:CollisionShape2D = $HoriCollisionShape2D
@onready var vert:CollisionShape2D = $VertCollisionShape2D

var _id:String
var _connects:String
var _connectsPosition:Vector2i
var _horizontalCheck:bool

func _ready() -> void:
	pass
	
func setProperties(id:String, horizontalCheck:bool, connects:String, connectsPostion: Vector2i, size:int = 4) -> void:
	_id = id
	_connects = connects
	_connectsPosition = connectsPostion
	_horizontalCheck = horizontalCheck
	
	#hori.set
	var calculatedSize:float = 16 * size
	if horizontalCheck:
		vert.disabled = true
	else:
		hori.disabled = true

		
func _physics_process(delta: float) -> void:
	for b:Node2D in get_overlapping_bodies():
		if b.is_in_group("player"):
			Events.ROOM_LOAD.emit(_connects)
			Events.PLAYER_MOVE_TO.emit(_connectsPosition)

	
	
