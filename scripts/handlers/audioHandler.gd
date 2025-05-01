extends Node2D

func _ready() -> void:
	Events.connect("PLAY_SOUND_EFFECT", _on_playSoundEffect)
	
func _on_playSoundEffect(id:String) -> void:
	pass
