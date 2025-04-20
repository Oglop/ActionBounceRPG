extends AnimatedSprite2D
	
func setProperties(position:Vector2, direction:int) -> void:
	if direction < 0:
		scale.x = -1
	global_position = position
	# check whitch weapon is in use
	play("short")


func _on_animation_finished() -> void:
	queue_free()
