extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var area  = $Area2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("btn_up"):
		for b:Node in area.get_overlapping_bodies():
				if b.is_in_group("player"):
					Events.DATA_SAVE_SLOT.emit(Data.saveSlot, global_position)
					Events.SHOW_ACCEPT_MENU.emit("Game was saved on slot " + str(Data.saveSlot) + ".")
		
	
