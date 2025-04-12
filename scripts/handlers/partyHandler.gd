extends Node2D

var _test:int = 0

func _initTail() -> void:
	if Data.tailNo1Type != Enums.tailType.NONE:
		var tail1 = SceneLoader.getScene("tail")
		self.add_child(tail1)
		tail1.setProperties(1, Data.tailNo1Type)
	if Data.tailNo2Type != Enums.tailType.NONE:
		var tail2 = SceneLoader.getScene("tail")
		self.add_child(tail2)
		tail2.setProperties(2, Data.tailNo2Type)



func _ready() -> void:
	_initTail()
