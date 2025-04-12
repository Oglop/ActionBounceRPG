extends Node

var hpCurrent:int = 0
var hpMax:int = 0
var xp:int = 0
var lv:int = 1
var strength:int = 0
var toughness:int = 0
var critChance:int = 0
var armor:int = 0
var weapon:int = 0


var playerDirections:Array:
	get:
		if playerDirections.size() == 0 or playerDirections == null:
			playerDirections.resize(40)
			playerDirections.fill(1)
		return playerDirections
	set(value):
		playerDirections = value
			
var playerPositions:Array :
	get:
		if playerPositions.size() == 0 or playerPositions == null:
			playerPositions.resize(40)
			playerPositions.fill(Vector2i(0,0))
		return playerPositions
	set(value):
		playerPositions = value
		
		
var tailNo1Type:Enums.tailType = Enums.tailType.POOCH
var tailNo2Type:Enums.tailType = Enums.tailType.WIZARD
