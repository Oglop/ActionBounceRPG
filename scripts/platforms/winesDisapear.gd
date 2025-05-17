extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collisionBox = $CollisionShape2D
var s:skills

func _ready() -> void:
	s = skills.new()
	if s.canTrackPath:
		collisionBox.disabled = true
		sprite.visible = false
