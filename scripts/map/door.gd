extends Node2D

@onready var check:Area2D = $Area2D
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D

var _id:String
var _locked:bool
var _connects:String
var _connectsPosition:Vector2i

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("btn_up"):
		for b:Node in check.get_overlapping_bodies():
			if b.is_in_group("player"):
				Events.PLAY_SOUND_EFFECT.emit(Statics.SFX_PLAYER_PASS_DOOR)
				Events.ROOM_LOAD.emit(_connects)
				Events.PLAYER_MOVE_TO.emit(_connectsPosition)
			
	
func setProperties(id:String, connects:String, locked:bool, connectsPostion: Vector2i, type:String) -> void:
	_id = id
	_locked = locked
	_connects = connects
	_connectsPosition = connectsPostion
	sprite.play(type)
	
