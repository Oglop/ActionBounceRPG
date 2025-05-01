extends Node2D

@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	pass
	
func setProperties(dir:int, combo:int = 0) -> void:
	if dir < 0:
		sprite.flip_h
		
	if combo == 0:
		sprite.play("one")
	elif combo == 1:
		sprite.play("two")

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
