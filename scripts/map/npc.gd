extends Node2D

@onready var area = $Area2D
@onready var sprite = $AnimatedSprite2D
var _id:String
var _type:Enums.npcType
var _animation:String
var npc:Dictionary
var f:functions
var _questStep:int = -1
var _questNext:int = -1

func _ready() -> void:
	f = functions.new()
	if _flippable():
		if f.chance(50):
			scale.x = -1
		
	
func _flippable() -> bool:
	match _type:
		"villager_a": return true
		"villager_b": return true
		"villager_c": return true
		"villager_d": return true
		_: return false
	
	
func _physics_process(delta: float) -> void:
	sprite.play(_animation)
	if Input.is_action_just_pressed("btn_up"):
		for b:Node in area.get_overlapping_bodies():
			if b.is_in_group("player"):
				Events.PLAYER_JUMP_BLOCK.emit()
				get_tree().paused = true
				if npc.has("type"):
					if npc.type == "change-party":
						Events.ROOM_CHANGE_PARTY.emit()
					elif npc.type == "info":
						Events.ROOM_LOAD_NPC.emit(_id)
					elif npc.type == "healer":
						Events.ADD_HP.emit(999)
						Events.ADD_STAMINA.emit(999)
						Events.ROOM_LOAD_NPC.emit(_id)
					elif npc.type == "potion":
						if Data.potionCollected:
							Events.PLAYER_REFILL_POTION.emit()
						Events.ROOM_LOAD_NPC.emit(_id)
					elif npc.type == "quest":
						Events.ROOM_LOAD_NPC_QUEST.emit(_id, _questStep)
						Data.quests[_id] = _questNext
						
					
				else:
					Events.ROOM_LOAD_NPC.emit(_id)
	
	
func setProperties(id:String) -> void:
	_id = id
	npc = Data.npcData[id]
	_animation = npc.animation
	
func setPropertiesQuest(questStep:int, questNext:int) -> void:
	_questStep = questStep
	_questNext = questNext
	
