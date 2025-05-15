extends Node2D

@onready var playerJump = $player_jump
@onready var playerBounce = $player_bounce
@onready var blockBullet = $block_bullet

var f:functions

func _ready() -> void:
	Events.connect("PLAY_SOUND_EFFECT", _on_playSoundEffect)
	f = functions.new()
	
	
func playAtRandomPitch(player:AudioStreamPlayer) -> void:
	player.pitch_scale = f.getRandomFloatInRange(0.8,1.2)
	player.play()
	
	
func playAtPitch(player:AudioStreamPlayer, pitch:float = 1.0) -> void:
	player.pitch_scale = pitch
	player.play()
	
	
func _on_playSoundEffect(id:String) -> void:
	match id:
		Statics.SFX_PLAYER_JUMP: playAtRandomPitch(playerJump)
		Statics.SFX_PLAYER_BOUNCE: playAtRandomPitch(playerBounce)
		Statics.SFX_PLAYER_BLOCK_BULLET: playAtPitch(blockBullet)
