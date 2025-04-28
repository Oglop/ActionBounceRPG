extends Node2D

@onready var lbl = $Panel/VBoxContainer/Label
@onready var sprite = $Panel/MarginContainer/ItemIcons

func _ready() -> void:
	Events.connect("OPEN_TREASURE", _on_openChest)
	visible = false
	
func _physics_process(delta: float) -> void:
	if visible && Input.is_action_just_pressed("btn_jump"):
		get_tree().paused = false
		visible = false
		_setText("")


func _on_openChest(id:String) -> void:
	_setText(id)
	_setAnimation(id)
	get_tree().paused = true
	visible = true


func _setText(id:String) -> void:
	lbl.text = Data.textData[id].collect
	
func _setAnimation(id:String) -> void:
	sprite.play(id)
