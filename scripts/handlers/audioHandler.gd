extends Node2D

@onready var playerJump = $player_jump
@onready var playerBounce = $player_bounce

var f:functions

func _ready() -> void:
	Events.connect("PLAY_SOUND_EFFECT", _on_playSoundEffect)
	f = functions.new()
	
	
func playAtRandomPitch(player:AudioStreamPlayer) -> void:
	player.pitch_scale = f.getRandomFloatInRange(0.8,1.2)
	player.play()
	

	
func _on_playSoundEffect(id:String) -> void:
	match id:
		Statics.SFX_PLAYER_JUMP: playAtRandomPitch(playerJump)
		Statics.SFX_PLAYER_BOUNCE: playAtRandomPitch(playerBounce)
