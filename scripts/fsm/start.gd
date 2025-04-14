extends Node2D

func _ready() -> void:
	Data.armor = 0
	Data.critChance = 4
	Data.strength = 4
	Data.hpMax = 24
	Data.hpCurrent = 24
	Data.lv = 1
	Data.toughness = 2
	
	get_tree().change_scene_to_file(Statics.ROOM_TEMPLATE)
