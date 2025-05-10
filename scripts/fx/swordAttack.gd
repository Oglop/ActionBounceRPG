extends Node2D

var f:functions = functions.new()
@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer

func _ready() -> void:
	pass
	
func setProperties(dir:int, combo:int) -> void:
	var noSlash:int = f.randomInt(2,3)
	for i in noSlash:
		Events.FX_SWORD_SLASH.emit(global_position, dir)
	if dir < 0:
		scale.x = -1
	timer.start(0.2)


func _on_timer_timeout() -> void:
	queue_free()
