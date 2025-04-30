extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var area = $Area2D

var _id:String
var _on:bool
var _flippable:bool
var _type:String

func _ready() -> void:
	_on = false	

	
func setProperties(id:String, default:bool, flippable:bool, type:String) -> void:
	_id = id
	if Data.switches.has(id):
		_on = Data.switches[id]
	else:
		_on = default
	_flippable = flippable
	_type = type


func _play() -> void:
	if _type == "wood":
		if _on:
			sprite.play("wood_on")
		else:
			sprite.play("wood_off")
	elif _type == "stone":
		if _on:
			sprite.play("stone_on")
		else:
			sprite.play("stone_off")


func _physics_process(delta: float) -> void:
	_play()
	if Input.is_action_just_pressed("btn_up"):
		for b:Node in area.get_overlapping_bodies():
				if b.is_in_group("player"):
					if _flippable || !_flippable && !_on:
						_on = !_on
					Events.ROOM_SWITCH_FLIPPED.emit(_id, _on)
		
	
