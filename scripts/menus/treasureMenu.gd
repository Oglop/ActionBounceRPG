extends Node2D

@onready var lbl = $Panel/VBoxContainer/Label
@onready var sprite = $Panel/MarginContainer/ItemIcons

func _ready() -> void:
	Events.connect("OPEN_TREASURE", _on_openChest)
	visible = false
	
func _physics_process(delta: float) -> void:
	if visible && Input.is_action_just_pressed("btn_jump"):
		Events.PLAYER_JUMP_BLOCK.emit()
		get_tree().paused = false
		visible = false
		_setText("_")


func _on_openChest(id:String) -> void:
	_setText(id)
	_setAnimation(id)
	get_tree().paused = true
	visible = true


func _setText(id:String) -> void:
	lbl.text = "Obtained\n" + Data.textData[id].name
	
func _setAnimation(id:String) -> void:
	sprite.play(id)
