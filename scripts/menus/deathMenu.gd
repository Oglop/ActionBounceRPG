extends Node2D

var acceptInput:bool = false


func _ready() -> void:
	Events.connect("ROOM_SHOW_DEATH_MENU", _on_showDeathMenu)
	visible = false


func _physics_process(delta: float) -> void:
	if acceptInput && Input.is_action_just_pressed("btn_accept"):
		get_tree().change_scene_to_file(Statics.ROOM_GAME_START)


func _on_showDeathMenu() -> void:
	visible = true
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	acceptInput = true
