extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var area = $Area2D

var _id:String


func _ready() -> void:
	pass

	
func setProperties(id:String) -> void:
	_id = id


func _physics_process(delta: float) -> void:
	pass
