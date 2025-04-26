extends Node2D

@onready var lbl = $Panel/VBoxContainer/Label
@onready var timer = $Timer

var blockedForInput:bool = true


func _ready() -> void:
	visible = false
	blockedForInput = true
	Events.connect("SHOW_ACCEPT_MENU", _on_showAcceptMenu)


func _physics_process(delta: float) -> void:
	if !blockedForInput:
		if Input.is_action_just_pressed("btn_jump"):
			visible = false
			blockedForInput = true
			get_tree().paused = false

func _on_showAcceptMenu(text:String) -> void:
	lbl.text = text
	visible = true
	blockedForInput = true
	get_tree().paused = true
	timer.start(0.8)


func _on_timer_timeout() -> void:
	blockedForInput = false
	
