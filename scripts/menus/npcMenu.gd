extends Node2D

@onready var infoPanel = $InfoPanel
@onready var infoLabel = $InfoPanel/VBoxContainer/Label

var index:int = 0
var messages:Array = []
var _nextProgress:int = -1

func _ready() -> void:
	
	Events.connect("ROOM_LOAD_NPC", _on_loadNPC)
	Events.connect("ROOM_LOAD_NPC_QUEST", _on_loadNPCQuest)
	infoPanel.visible = false


func _on_loadNPC(id:String) -> void:
	var npc:Dictionary = Data.npcData[id]
	messages = npc.messages
	_setInfo(npc.messages[0].text)
	#for msg in messages:
	#	if msg.type == "info":
	#		_setInfo(msg.text)
	#	elif msg.type == "healer":
	#		_setInfo(msg.text)
			
func _on_loadNPCQuest(id:String, questStep:int) -> void:
	if Data.quests[id] == questStep:
		messages = Data.questData[id][str(questStep)].messages
		if Data.questData[id][str(questStep)].has("items"):
			for item in Data.questData[id][str(questStep)].items:
				Data.addItemFromString(item)
		_setInfo(messages[0].text)
	else:
		var npc:Dictionary = Data.npcData[id]
		messages = npc.messages
		_setInfo(npc.messages[0].text)

			
func _setNextText(index:int) -> void:
	if messages.size() == 0 || index >= messages.size():
		infoPanel.visible = false
		messages = []
		Events.PLAYER_JUMP_BLOCK.emit()
		get_tree().paused = false
		return 
	if messages[index].type == "info":
		_setInfo(messages[index].text)
	
	
func _setInfo(text:String) -> void:
	infoPanel.visible = true
	infoLabel.text = text
	
func _physics_process(delta: float) -> void:
	if infoPanel.visible:
		if Input.is_action_just_pressed("btn_jump"):
			index += 1
			infoPanel.visible = false
			_setNextText(index)
	
