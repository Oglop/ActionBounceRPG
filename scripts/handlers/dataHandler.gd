extends Node2D

const START_ROOM_NAME:String = "start"
const DEBUG_ROOM_NAME:String = "debug"
var DEBUG_MODE:bool = false

const path:String = "user://savegame_%s.save"
const data_x:String = "x"
const data_y:String = "y"
const data_saveSpotRoomId:String = "saveSpotRoomId"
const data_xp:String = "xp"
const data_xpTotal:String = "xpTotal"
const data_next:String = "xpNext"
const data_lv:String = "lv"
const data_strength:String = "strength"
const data_toughness:String = "toughness"
const data_hp:String = "health"
const data_st:String = "stamina"
const data_fireBallTomeCollected:String = "fireBallTomeCollected"
const data_candleCollected:String = "candleCollected"
const data_spiritStoneCollected:String = "spiritStoneCollected"
const data_infinitySymbolCollected:String = "infinitySymbolCollected"
const data_tailNo1:String = "tailNo1"
const data_tailNo2:String = "tailNo2"
const data_armor:String = "armor"
const data_weapon:String = "weapon"
const data_shield:String = "shield"
const data_thiefsGlovesCollected:String = "thiefsGlovesCollected"
const data_lockPicksCollected:String = "lockPicksCollected"
const data_powerRingCollected:String = "powerRingCollected"
const data_animalIconCollected:String = "animalIconCollected"
const data_diggingClawsCollected:String = "diggingClawsCollected"
const data_healingRodCollected:String = "healingRodCollected"
const data_holySymbolCollected:String = "holySymbolCollected"
const data_ancientScriptCollected:String = "ancientScriptCollected"
const data_iceCrystalCollected:String = "iceCrystalCollected"
const data_weaponTier1Collected:String = "weaponTier1Collected"
const data_weaponTier2Collected:String = "weaponTier2Collected"
const data_weaponTier3Collected:String = "weaponTier3Collected"
const data_armorTier1Collected:String = "armorTier1Collected"
const data_armorTier2Collected:String = "armorTier2Collected"
const data_armorTier3Collected:String = "armorTier3Collected"
const data_shieldTier1Collected:String = "shieldTier1Collected"
const data_shieldTier2Collected:String = "shieldTier2Collected"
const data_shieldTier3Collected:String = "shieldTier3Collected"
const data_potionCollected:String = "potionCollected"
const data_potion:String = "potion"
const data_featherCollected:String = "featherCollected"
const data_switches:String = "switches"
const data_quests:String = "quests"

var f:functions


func _ready() -> void:
	f = functions.new()
	Events.connect("DATA_LOAD_SLOT", _on_loadSlot)
	Events.connect("DATA_SAVE_SLOT", _on_saveSlot)
	Events.connect("GAME_NEW_GAME", _on_newGame)
	

func _getSaveData(position:Vector2) -> Dictionary:
	Data.saveSpotRoomId = Data.currentRoomId
	var data:Dictionary = {
		data_x: position.x,
		data_y: position.y,
		data_saveSpotRoomId: Data.saveSpotRoomId,
		data_next: Data.next,
		data_xp : Data.xp,
		data_hp: Data.hpCurrent,
		data_st: Data.staminaCurrent,
		# data_xpTotal: Data.xpTotal,
		data_lv: Data.lv,
		data_strength: Data.strength,
		data_toughness: Data.toughness,
		data_tailNo1: Enums.tailTypeToString(Data.tailNo1Type),
		data_tailNo2: Enums.tailTypeToString(Data.tailNo2Type),
		data_armor: Enums.armorsToString(Data.armor),
		data_weapon: Enums.weaponToString(Data.weapon),
		data_shield: Enums.shieldsToString(Data.shield),
		data_thiefsGlovesCollected: f.boolToInt(Data.thiefsGlovesCollected) ,
		data_powerRingCollected: f.boolToInt(Data.powerRingCollected),
		data_fireBallTomeCollected: f.boolToInt(Data.fireBallTomeCollected),
		data_candleCollected: f.boolToInt(Data.candleCollected),
		data_spiritStoneCollected: f.boolToInt(Data.spiritStoneCollected),
		data_infinitySymbolCollected: f.boolToInt(Data.infinitySymbolCollected),
		data_animalIconCollected: f.boolToInt(Data.animalIconCollected),
		data_diggingClawsCollected: f.boolToInt(Data.diggingClawsCollected),
		data_lockPicksCollected: f.boolToInt(Data.lockPicksCollected),
		data_healingRodCollected: f.boolToInt(Data.healingRodCollected),
		data_holySymbolCollected: f.boolToInt(Data.holySymbolCollected),
		data_ancientScriptCollected: f.boolToInt(Data.ancientScriptCollected),
		data_iceCrystalCollected: f.boolToInt(Data.iceCrystalCollected),
		data_weaponTier1Collected: f.boolToInt(Data.weaponTier1Collected),
		data_weaponTier2Collected: f.boolToInt(Data.weaponTier2Collected),
		data_weaponTier3Collected: f.boolToInt(Data.weaponTier3Collected),
		data_armorTier1Collected: f.boolToInt(Data.armorTier1Collected),
		data_armorTier2Collected: f.boolToInt(Data.armorTier2Collected),
		data_armorTier3Collected: f.boolToInt(Data.armorTier3Collected),
		data_shieldTier1Collected: f.boolToInt(Data.shieldTier1Collected),
		data_shieldTier2Collected: f.boolToInt(Data.shieldTier2Collected),
		data_shieldTier3Collected: f.boolToInt(Data.shieldTier3Collected),
		data_potionCollected: f.boolToInt(Data.potionCollected),
		data_potion: Enums.potionTypeToString(Data.potion),
		data_featherCollected: f.boolToInt(Data.featherCollected),
		data_switches: Data.switches,
		data_quests: Data.quests,
	}
	return data


func _setSaveData(data:Dictionary) -> void:
	Data.saveSpotY = data[data_y]
	Data.saveSpotX = data[data_x]
	Data.saveSpotRoomId = data[data_saveSpotRoomId]
	Data.lv = data[data_lv]
	Data.xp = data[data_xp]
	#Data.xpTotal = data[data_xp]
	Data.hpCurrent = data[data_hp]
	Data.staminaCurrent = data[data_st]
	Data.strength = data[data_strength]
	Data.toughness = data[data_toughness]
	Data.tailNo1Type = Enums.stringToTailType(data[data_tailNo1])
	Data.tailNo2Type = Enums.stringToTailType(data[data_tailNo2])
	Data.armor = Enums.stringToArmors(data[data_armor])
	Data.weapon = Enums.stringToWeapon(data[data_weapon])
	Data.shield = Enums.stringToShields(data[data_shield])
	Data.thiefsGlovesCollected = f.intToBool(data[data_thiefsGlovesCollected])
	Data.powerRingCollected = f.intToBool(data[data_powerRingCollected])
	Data.fireBallTomeCollected = f.intToBool(data[data_fireBallTomeCollected])
	Data.candleCollected = f.intToBool(data[data_candleCollected])
	Data.spiritStoneCollected = f.intToBool(data[data_spiritStoneCollected])
	Data.infinitySymbolCollected = f.intToBool(data[data_infinitySymbolCollected])
	Data.animalIconCollected = f.intToBool(data[data_animalIconCollected])
	Data.diggingClawsCollected = f.intToBool(data[data_diggingClawsCollected])
	Data.lockPicksCollected = f.intToBool(data[data_lockPicksCollected])
	Data.healingRodCollected = f.intToBool(data[data_healingRodCollected])
	Data.holySymbolCollected = f.intToBool(data[data_holySymbolCollected])
	Data.ancientScriptCollected = f.intToBool(data[data_ancientScriptCollected])
	Data.iceCrystalCollected = f.intToBool(data[data_iceCrystalCollected])
	Data.weaponTier1Collected = f.intToBool(data[data_weaponTier1Collected])
	Data.weaponTier2Collected = f.intToBool(data[data_weaponTier2Collected])
	Data.weaponTier3Collected = f.intToBool(data[data_weaponTier3Collected])
	Data.armorTier1Collected = f.intToBool(data[data_armorTier1Collected])
	Data.armorTier2Collected = f.intToBool(data[data_armorTier2Collected])
	Data.armorTier3Collected = f.intToBool(data[data_armorTier3Collected])
	Data.shieldTier1Collected = f.intToBool(data[data_shieldTier1Collected])
	Data.shieldTier2Collected = f.intToBool(data[data_shieldTier2Collected])
	Data.shieldTier3Collected = f.intToBool(data[data_shieldTier3Collected])
	Data.potionCollected = f.intToBool(data[data_potionCollected])
	Data.featherCollected = f.intToBool(data[data_featherCollected])
	Data.potion = Enums.stringToPotionType(data[data_potion])
	Data.switches = data[data_switches]
	Data.quests = data[data_quests]
	

func _getSlotPath(slot:int) -> String:
	return path % str(slot)
	

func _on_saveSlot(slot:int, position:Vector2) -> void:
	var fileAccess:FileAccess = FileAccess.open(_getSlotPath(slot), FileAccess.WRITE)
	var data:String = JSON.stringify(_getSaveData(position))
	fileAccess.store_line(data)

func _on_loadSlot(slot:int = 1) -> void:
	if !FileAccess.file_exists(_getSlotPath(slot)) || DEBUG_MODE:
		_on_newGame(1)
		return
		
	var fileAccess:FileAccess = FileAccess.open(_getSlotPath(slot), FileAccess.READ)
	while fileAccess.get_position() < fileAccess.get_length():
		var text:String = fileAccess.get_line()
		var json = JSON.new()
		var e:Error = json.parse(text)
		if e == OK:
			_setSaveData(json.get_data())
		
func _on_newGame(slot:int) -> void:
	const startLevel:String = "1"
	if DEBUG_MODE:
		Data.saveSpotRoomId = DEBUG_ROOM_NAME
		Data.saveSpotX = Data.roomData[DEBUG_ROOM_NAME].x
		Data.saveSpotY = Data.roomData[DEBUG_ROOM_NAME].y
		Data.armor = Enums.armors.LEATHER
		Data.armorTier1Collected = true
		Data.shield = Enums.shields.ROUND
		Data.shieldTier1Collected = true
		Data.weapon = Enums.weapons.SHORT
		Data.weaponTier1Collected = true
	else:
		Data.saveSpotRoomId = START_ROOM_NAME
		Data.saveSpotX = Data.roomData[START_ROOM_NAME].x
		Data.saveSpotY = Data.roomData[START_ROOM_NAME].y
		Data.armor = Enums.armors.NONE
		Data.armorTier1Collected = false
		Data.shield = Enums.shields.NONE
		Data.shieldTier1Collected = false
		Data.weapon = Enums.weapons.NONE
		Data.weaponTier1Collected = false
		
	
	Data.hpMax = Data.levelData[startLevel].maxHp
	Data.hpCurrent = Data.hpMax
	Data.staminaMax = Data.levelData[startLevel].maxStamina
	Data.staminaCurrent = Data.staminaMax
	Data.lv = 1
	Data.next = Data.levelData[startLevel].need
	Data.xp = 0
	Data.strength = Data.levelData[startLevel].strength
	Data.toughness = Data.levelData[startLevel].toughness
	Data.critChance = Data.levelData[startLevel].critChance
	
	Data.armorTier2Collected = false
	Data.armorTier3Collected = false
	
	Data.shieldTier2Collected = false
	Data.shieldTier3Collected = false
	
	Data.weaponTier2Collected = false
	Data.weaponTier3Collected = false
	
	Data.tailNo1Type = Enums.tailType.NONE
	Data.tailNo2Type = Enums.tailType.NONE
	
	Data.potionCollected = false
	Data.featherCollected = false
	Data.thiefsGlovesCollected = false
	Data.lockPicksCollected = false
	Data.powerRingCollected = false
	Data.fireBallTomeCollected = false
	Data.wizItem3 = false
	Data.candleCollected = false
	Data.spiritStoneCollected = false
	Data.infinitySymbolCollected = false
	Data.animalIconCollected = false
	Data.diggingClawsCollected = false
	Data.fireBallTomeSelected = false
	Data.healingRodCollected = false
	Data.holySymbolCollected = false
	Data.ancientScriptCollected = false
	Data.iceCrystalCollected = false
	
	

		
		
	
