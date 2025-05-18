extends Node

var f:functions
var newGame:bool = false

func _ready() -> void:
	f = functions.new()
	Events.connect("ADD_XP", _on_addXP)
	Events.connect("ADD_HP", _on_addHP)
	Events.connect("PLAYER_REFILL_POTION", _on_refillPotion)
	Events.connect("RECEIVE_DAMAGE", _on_receiveDamage)
	Events.connect("ADD_STAMINA", _on_addStamina)
	Events.connect("SUB_STAMINA", _on_subStamina)
	Events.connect("EXPLORE_AREA", _on_exploreArea)

var saveSpotY:int:
	get:
		if saveSpotY == null:
			saveSpotY = 0
		return saveSpotY
		
var currentRoomId:String:
	get:
		if currentRoomId == null || currentRoomId == "":
			currentRoomId = saveSpotRoomId
		return currentRoomId
	set(value):
		currentRoomId = value
		
var saveSpotRoomId:String:
	get:
		if saveSpotRoomId == null || saveSpotRoomId == "":
			saveSpotRoomId = "start"
		return saveSpotRoomId
	set(value):
		saveSpotRoomId = value
		
var saveSpotX:int:
	get:
		if saveSpotX == null:
			saveSpotX = 0
		return saveSpotX

var saveSlot:int:
	get:
		if saveSlot == 0 || saveSlot == null:
			saveSlot = 1
		return saveSlot

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
		

var textData:Dictionary:
	get:
		if textData == null || textData.size() == 0:
			var file:FileAccess = FileAccess.open(Statics.TEXT_DATA, FileAccess.READ)
			textData = JSON.parse_string(file.get_as_text())
		return textData
		
var questData:Dictionary:
	get:
		if questData == null || questData.size() == 0:
			var file:FileAccess = FileAccess.open(Statics.QUEST_DATA, FileAccess.READ)
			questData = JSON.parse_string(file.get_as_text())
		return questData
		

var hpCurrent:int:
	get:
		if hpCurrent == null:
			hpCurrent = 0
		return hpCurrent
	set(value):
		if value > hpMax:
			hpCurrent = hpMax
		elif value < 0:
			hpCurrent = 0
		else:
			hpCurrent = value
		
		
var hpMax:int:
	get:
		return levelData[str(lv)].maxHp
	set(value):
		hpMax = value
		
var next:int:
	get:
		if next == null || next == 0:
			next = getMaxXPAtLevel(lv)
		return next
	set (value):
		next = value
		
var xp:int:
	get:
		if xp == null:
			xp = 0
		return xp
	set(value):
		next = getMaxXPAtLevel(lv)
		xp = value
		if xp >= next && lv < Statics.LEVEL_MAX:
			lv += 1
			next = getMaxXPAtLevel(lv)
			
		
var lv:int = 1:
	get:
		if lv == null:
			lv = 1
		return lv
	set(value):
		lv = value
		
		
var staminaCurrent:int:
	get:
		if staminaCurrent == null:
			staminaCurrent = 0
		return staminaCurrent
	set(value):
		if value > staminaMax:
			staminaCurrent = staminaMax
		elif value < 0:
			staminaCurrent = 0
		else:
			staminaCurrent = value
		
		
var staminaMax:int:
	get:
		return levelData[str(lv)].maxStamina
	set(value):
		staminaMax = value
		
		
var strength:int:
	get:
		return levelData[str(lv)].strength
	set(value):
		strength = value
		
		
var toughness:int:
	get:
		return levelData[str(lv)].toughness
	set(value):
		toughness = value
		

var magic:int:
	get:
		return levelData[str(lv)].magic
	set(value):
		magic = value
	
	
var critChance:int:
	get:
		return levelData[str(lv)].critChance
	set(value):
		critChance = value
		
var attack:int:
	get:
		var multiplyer:float = f.getRandomFloatInRange(0.8, 1.2)
		
		var w:int  = equipmentData[Enums.weaponToString(weapon)].attack
		var a:int = strength + lv + w

		return int(a * multiplyer)
		
var attackRaw:int:
		get:
			var w:int  = equipmentData[Enums.weaponToString(weapon)].attack
			var a:int = strength + lv + w
			return int(a)
		
var defence:int:
	get:
		var multiplyer:float = f.getRandomFloatInRange(0.8, 1.2)
		var w:int  = equipmentData[Enums.armorsToString(armor)].defence
		var d:int = toughness + lv + w
		return int(d * multiplyer)
		
var defenceRaw:int:
	get:
		var w:int  = equipmentData[Enums.armorsToString(armor)].defence
		var d:int = toughness + lv + w
		return int(d)
		
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
		
		
var strengthBonus:int:
	get:
		if tailNo1Type == Enums.tailType.POOCH || tailNo2Type == Enums.tailType.POOCH:
			return 1
		return 0
		
		
var toughnessBonus:int:
	get:
		if tailNo1Type == Enums.tailType.CLERIC || tailNo2Type == Enums.tailType.CLERIC:
			return 1
		return 0
		
		
var potion:Enums.potionType:
	get:
		if potion == null:
			potion = Enums.potionType.EMPTY
		return potion
	set(value):
		potion = potion
		
		

		
var switches:Dictionary:
	get:
		if switches == null:
			switches = {}
		return switches
	set(value):
		switches = value
		
		
var areasExplored:Dictionary:
	get:
		if areasExplored == null:
			areasExplored = {}
		return areasExplored
	set(value):
		areasExplored = value
		
		
var quests:Dictionary:
	get:
		if quests == null:
			quests = {}
		return quests
	set(value):
		quests = value
		
		
func fireballDamage() -> int:
	var lvBonus = 1
	if lv > 3 && lv <= 6:
		lvBonus = 2
	elif lv > 6 && lv <= 9:
		lvBonus = 3
	elif lv > 9 && lv <= 12:
		lvBonus = 4
	elif lv > 12 && lv <= 15:
		lvBonus = 5
	else:
		lvBonus = 6
		
	var dmg:int = int(lvBonus + (lv * 0.5))
	print_debug("fireballDamage: " + str(dmg))
	return dmg
		
		
func thiefknifeDamage() -> int:
	var bonus:int = 0
	var maxPossibleHits:int = 1 + (lv * 0.5)
	var hits:int = f.randomInt(1, maxPossibleHits)
	for i in hits:
		var critical:bool = f.chance(Data.critChance)
		bonus += f.randomInt(0,2)
		while critical:
			bonus += f.randomInt(0,2)
			critical = f.chance(Data.critChance)
	print_debug("thiefknifeDamage: " + str(bonus))
	return bonus
	
func elfArrowDamage() -> int:
	var bonus:int = 0
	var critical:bool = f.chance(Data.critChance)
	#var hits:int = f.randomInt(1, maxPossibleHits)
	var multiplyer:float = f.getRandomFloatInRange(1.0, 2.0)
	if critical:
		multiplyer = f.getRandomFloatInRange(2.0, 4.0)
	bonus += lv * multiplyer
	print_debug("elfArrowDamage: " + str(bonus))
	return bonus
	
	
	
		
var tailNo1Type:Enums.tailType = Enums.tailType.NONE
var tailNo2Type:Enums.tailType = Enums.tailType.NONE
var potionCollected:bool = false
var featherCollected:bool = false
var thiefsGlovesCollected:bool = false
var lockPicksCollected:bool = false
var powerRingCollected:bool = false
var fireBallTomeCollected:bool = false
var fireBallTomeSelected:bool = false
var wizItem3:bool = false
var candleCollected:bool = false
var spiritStoneCollected:bool = false
var infinitySymbolCollected:bool = false
var animalIconCollected:bool = false
var diggingClawsCollected:bool = false
var healingRodCollected:bool = false
var holySymbolCollected:bool = false
var ancientScriptCollected:bool = false
var iceCrystalCollected:bool = false
var weaponTier1Collected:bool = false
var weaponTier2Collected:bool = false
var weaponTier3Collected:bool = false
var armorTier1Collected:bool = false
var armorTier2Collected:bool = false
var armorTier3Collected:bool = false
var shieldTier1Collected:bool = false
var shieldTier2Collected:bool = false
var shieldTier3Collected:bool = false

func _on_addXP(value:int) -> void:
	xp += value
	
func _on_addHP(value:int) -> void:
	if hpCurrent + value > hpMax:
		hpCurrent = hpMax
	else:
		hpCurrent += value
		
func _on_receiveDamage(dmg:int) -> void:
	var appliedDmg:int = f.minusLimit(dmg, Data.defence, 0)
	if hpCurrent - appliedDmg >= 0:
		hpCurrent -= appliedDmg
	else:
		hpCurrent = 0
		
func _on_refillPotion() -> void:
	Data.potion = Enums.potionType.FULL
	
func getMaxXPAtLevel(level:int) -> int:
	return levelData[str(lv)]["need"]
	
func _on_addStamina(value:int) -> void:
	Data.staminaCurrent += value
	
func _on_subStamina(value:int) -> void:
	Data.staminaCurrent -= value
	
func addItemFromString(item:String) -> void:
	if item == Statics.ID_SHORT_SWORD:
		weaponTier1Collected = true
	elif item == Statics.ID_ROUND_SHIELD:
		shieldTier1Collected = true
	elif item == Statics.ID_LEATHER_ARMOR:
		armorTier1Collected = true
		
func _on_exploreArea(area:String) -> void:
	if !areasExplored.has(area):
		areasExplored[area] = true
	
