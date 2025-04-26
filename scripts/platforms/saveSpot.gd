extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var area  = $Area2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("btn_up"):
		Events.DATA_SAVE_SLOT.emit(1)
		
	
