extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var f:functions = functions.new()

func _ready() -> void:
	var i:int = f.randomInt(0,2)
	match  i:
		0: sprite.play("one") 
		1: sprite.play("two")
		2: sprite.play("three")
	await  get_tree().create_timer(0.3).timeout
	queue_free()
	
