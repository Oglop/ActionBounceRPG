extends StaticBody2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var area:Area2D = $Area2D
var _isBreaking:bool = false
var _breakTime:float = 0.6


func _physics_process(delta: float) -> void:
	for body:Node2D in area.get_overlapping_bodies():
		if body.is_in_group("player"):
			breakFloor()
	
func setProperties(type:String) -> void:
	sprite.play(type)
	
func breakFloor() -> void:
	if !_isBreaking:
		_isBreaking = true
		await get_tree().create_timer(_breakTime).timeout
		Events.FX_BLOCK_BREAKING.emit(Vector2(global_position.x + 8, global_position.y + 8))
		queue_free()
