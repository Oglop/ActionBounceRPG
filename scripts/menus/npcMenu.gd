extends Node2D

@onready var infoPanel = $InfoPanel
@onready var infoLabel = $InfoPanel/VBoxContainer/Label

var index:int = 0
var messages:Array = []

func _ready() -> void:
	
	Events.connect("ROOM_LOAD_NPC", _on_loadNPC)
	_setInvisible()

func _setInvisible() -> void:
	infoPanel.visible = false

func _on_loadNPC(id:String) -> void:
	var npc:Dictionary = Data.npcData[id]
	messages = npc.messages
	for msg in messages:
		if msg.type == "info":
			_setInfo(msg.text)
		elif msg.type == "healer":
			_setInfo(msg.text)
			
func _setNextText(index:int) -> void:
	if messages.size() == 0 || index >= messages.size():
		_setInvisible()
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
			_setInvisible()
			_setNextText(index)
	
