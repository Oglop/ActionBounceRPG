extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var area = $Area2D

var _id:String
var _on:bool

func _ready() -> void:
	_on = false	

	
func setProperties(id:String, default:bool) -> void:
	_id = id
	if Data.switches.has(id):
		_on = Data.switches[id]
	else:
		_on = default


func _physics_process(delta: float) -> void:
	if _on:
		sprite.play("on")
	else:
		sprite.play("off")
		
	if Input.is_action_just_pressed("btn_up"):
		for b:Node in area.get_overlapping_bodies():
				if b.is_in_group("player"):
					Events.ROOM_SWITCH_FLIPPED.emit(_id, _on)
