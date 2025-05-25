extends Node2D

@onready var lbl:Label = $Label

#var red:Color = Color(231.0,26.0,51.0)
#var white:Color = Color(246,246,246)
#var green:Color = Color(61,180,66)



var canMove:bool = false
var upVelocity:float = 0.0
var acceleration:float = 2.0

func _ready() -> void:
	await get_tree().create_timer(0.3).timeout
	canMove = true
	await get_tree().create_timer(0.3).timeout
	queue_free()
	
	
func updateLabelColor(color:Color) -> void:
	lbl.set("theme_override_colors/font_color", color)
	
	
func setProperties(value:int, critical:bool, damageTaken:bool, healing:bool) -> void:
	lbl.text = str(value)
	if healing:
		updateLabelColor(Color.FOREST_GREEN)
	elif damageTaken:
		updateLabelColor(Color.RED)
	else:
		updateLabelColor(Color.FLORAL_WHITE)
		

func _physics_process(delta: float) -> void:
	if canMove:
		upVelocity += acceleration
		global_position.y -= upVelocity * delta
