extends Node2D

@onready var area = $Area2D
@onready var sprite = $AnimatedSprite2D
var _open:bool
var _id:String
	
func _physics_process(delta: float) -> void:
	
	if _open:
		sprite.play("open")
	else:
		sprite.play("closed")
	
	if !_open:
		if Input.is_action_just_pressed("btn_up"):
			for b:Node in area.get_overlapping_bodies():
				if b.is_in_group("player"):
					openTreasure(_id)


func setProperties(id:String) -> void:
	_id = id
	_open = isOpen()
	
func isOpen() -> bool:
	if _id == "powerRing":
		return Data.powerRingCollected
	return false
			

func openTreasure(id:String) -> void:
	if id == "powerRing" && Data.powerRingCollected == false:
		Data.powerRingCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	
