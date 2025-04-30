extends ParallaxBackground

@onready var sprite:Sprite2D = $ParallaxLayer/Sprite2D
var background_0001:Texture2D = preload("res://media/images/Background-0001.png")
var _currentBackground:String = ""


func _ready() -> void:
	Events.connect("ROOM_LOAD", _on_roomLoad)
	_on_roomLoad("start")
	
func _on_roomLoad(id:String) -> void:
	if _currentBackground == "":
		sprite.texture = background_0001
		
	if Data.roomData[id].has("background"):
		if _currentBackground != Data.roomData[id].background:
			_currentBackground = Data.roomData[id].background
			sprite.texture = _updateTexture()
		

func _updateTexture() -> Texture2D:
	match _currentBackground:
		"background_0001": return background_0001
		_: return background_0001
