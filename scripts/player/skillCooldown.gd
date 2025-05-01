extends Node2D

@onready var progressbar = $ProgressBar
@onready var sprite = $AnimatedSprite2D
var _id:String = ""

func _ready() -> void:
	pass
	
func _on_skillTriggered(id:String) -> void:
	progressbar.value = progressbar.max_value


func _physics_process(delta: float) -> void:
	if progressbar.value > progressbar.min_value:
		progressbar.value -= 1
		

func setProperties(id:String, visi:bool, maxValue:int) -> void:
	progressbar.max_value = maxValue
	visible = visi
	

func setAnimation() -> void:
	if _id == "":
		sprite.play("fireball1")
	
