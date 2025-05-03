extends Node2D

@onready var area = $Area2D
@onready var sprite = $AnimatedSprite2D
var _id:String
var _type:Enums.npcType
var _animation:String
var npc:Dictionary

func _ready() -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	sprite.play(_animation)
	if Input.is_action_just_pressed("btn_up"):
		for b:Node in area.get_overlapping_bodies():
			if b.is_in_group("player"):
				get_tree().paused = true
				if npc.has("type"):
					if npc.type == "change-party":
						Events.ROOM_CHANGE_PARTY.emit()
					elif npc.type == "info":
						Events.ROOM_LOAD_NPC.emit(_id)
					elif npc.type == "healer":
						Events.ADD_HP.emit(999)
						Events.ROOM_LOAD_NPC.emit(_id)
					
				else:
					Events.ROOM_LOAD_NPC.emit(_id)
	
	
func setProperties(id:String) -> void:
	_id = id
	npc = Data.npcData[id]
	_animation = npc.animation
	#_type = Enums.stringToNpcType(npc.type)
	
	
