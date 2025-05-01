extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer

func _ready() -> void:
	pass
	
func setProperties(dir:int, combo:int) -> void:
	if dir < 0:
		scale.x = -1
		
	if combo == 0:
		sprite.play("one")
	elif combo == 1:
		sprite.play("two")
	
	timer.start(0.2)


func _on_timer_timeout() -> void:
	queue_free()
