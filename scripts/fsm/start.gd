extends Node2D

@onready var dataHandler = $dataHandler

func _ready() -> void:
	
	dataHandler._on_loadSlot(1)
	get_tree().change_scene_to_file(Statics.ROOM_TEMPLATE)
	
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("btn_accept"):
		dataHandler._on_loadSlot(1)
		get_tree().change_scene_to_file(Statics.ROOM_TEMPLATE)
