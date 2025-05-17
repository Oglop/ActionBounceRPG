extends StaticBody2D

@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	pass
	
	
func setProperties(type:String) -> void:
	sprite.play(type)
	
