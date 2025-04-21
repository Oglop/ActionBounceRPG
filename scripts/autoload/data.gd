extends Node


func _ready() -> void:
	Events.connect("ADD_XP", _on_addXP)


var levelData:Dictionary:
	get:
		if levelData == null || levelData.size() == 0:
			var file:FileAccess = FileAccess.open(Statics.LEVEL_DATA, FileAccess.READ)
			levelData = JSON.parse_string(file.get_as_text())
		return levelData
		
		
var enemyData:Dictionary:
	get:
		if enemyData == null || enemyData.size() == 0:
			var file:FileAccess = FileAccess.open(Statics.ENEMY_DATA, FileAccess.READ)
			enemyData = JSON.parse_string(file.get_as_text())
		return enemyData
		
		
var equipmentData:Dictionary:
	get:
		if equipmentData == null || equipmentData.size() == 0:
			var file:FileAccess = FileAccess.open(Statics.EQUIPMENT_DATA, FileAccess.READ)
			equipmentData = JSON.parse_string(file.get_as_text())
		return equipmentData
		
		
var roomData:Dictionary:
	get:
		if roomData == null || roomData.size() == 0:
			var file:FileAccess = FileAccess.open(Statics.ROOM_DATA, FileAccess.READ)
			roomData = JSON.parse_string(file.get_as_text())
		return roomData
		
		
var npcData:Dictionary:
	get:
		if npcData == null || npcData.size() == 0:
			var file:FileAccess = FileAccess.open(Statics.NPC_DATA, FileAccess.READ)
			npcData = JSON.parse_string(file.get_as_text())
		return npcData
		

var hpCurrent:int:
	get:
		if hpCurrent == null:
			hpCurrent = 0
		return hpCurrent
	set(value):
		hpCurrent = value
		
		
var hpMax:int:
	get:
		if hpMax == null:
			hpMax = 0
		return hpMax
	set(value):
		hpMax = value
		
		
var xp:int:
	get:
		if xp == null:
			xp = 0
		return xp
	set(value):
		xp = value
		var next = getMaxXPAtLevel(lv)
		if xp >= next || lv < Statics.LEVEL_MAX:
			lv += 1
			xp -= next
		elif lv == Statics.LEVEL_MAX:
			xp = 0
			
		
var lv:int:
	get:
		if lv == null:
			lv = 1
		return lv
	set(value):
		lv = value
		
		
var staminaCurrent:int:
	get:
		if staminaCurrent == null:
			staminaCurrent = 1
		return staminaCurrent
	set(value):
		staminaCurrent = value
		
		
var staminaMax:int:
	get:
		if staminaMax == null:
			staminaMax = 1
		return staminaMax
	set(value):
		staminaMax = value
		
		
var strength:int:
	get:
		if strength == null:
			strength = 0
		return strength
	set(value):
		strength = value
		
		
var toughness:int:
	get:
		if toughness == null:
			toughness = 0
		return toughness
	set(value):
		toughness = value
	
	
var critChance:int:
	get:
		if critChance == null:
			critChance = 0
		return critChance
	set(value):
		critChance = value
		
		
var armor:Enums.armors:
	get:
		if armor == null:
			armor = Enums.armors.NONE
		return armor
	set(value):
		armor = value
		
		
var weapon:Enums.weapons:
	get:
		if weapon == null:
			weapon = Enums.weapons.NONE
		return weapon
	set(value):
		weapon = value
		

var shield:Enums.shields:
	get:
		if shield == null:
			shield = Enums.shields.NONE
		return shield
	set(value):
		shield = value


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
var thiefsGlovesCollected:bool = false
var powerRingCollected:bool = false
var startThingCollected:bool = false


func _on_addXP(value:int) -> void:
	xp += value
	
func getMaxXPAtLevel(level:int) -> int:
	return levelData[str(lv)]["need"]
