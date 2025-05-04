extends Node2D

@onready var dataHandler = $dataHandler

func _ready() -> void:
	
	dataHandler._on_loadSlot(1)
	
	
	
	get_tree().change_scene_to_file(Statics.ROOM_TEMPLATE)
