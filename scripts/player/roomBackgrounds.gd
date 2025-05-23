extends ParallaxBackground

@onready var sprite:Sprite2D = $ParallaxLayer/Sprite2D
var background_0001:Texture2D = preload("res://media/images/Background-0001.png")
var background_0002:Texture2D = preload("res://media/images/Background-0002.png")
var background_0003:Texture2D = preload("res://media/images/Background-0003.png")
var _currentBackground:String = ""


func _ready() -> void:
	Events.connect("ROOM_LOAD", _on_roomLoad)
	_on_roomLoad("start")
	
func _on_roomLoad(id:String) -> void:
	if _currentBackground == "":
		sprite.texture = background_0002
		
	if Data.roomData[id].has("background"):
		if _currentBackground != Data.roomData[id].background:
			_currentBackground = Data.roomData[id].background
			sprite.texture = _updateTexture()
		

func _updateTexture() -> Texture2D:
	match _currentBackground:
		Statics.ROOM_BACKGROUND_SKY: return background_0001
		Statics.ROOM_BACKGROUND_BLACK: return background_0002
		Statics.ROOM_BACKGROUND_GOLDEN_FOREST: return background_0003
		_: return background_0001
