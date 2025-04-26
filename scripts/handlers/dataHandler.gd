extends Node2D

const path:String = "user://savegame_%s.save"
const data_x:String = "x"
const data_y:String = "y"
const data_xp:String = "xp"
const data_lv:String = "lv"
const data_strength:String = "strength"
const data_toughness:String = "toughness"
const data_tailNo1:String = "tailNo1"
const data_tailNo2:String = "tailNo2"
const data_armor:String = "armor"
const data_weapon:String = "weapon"
const data_shield:String = "shield"
const data_thiefsGlovesCollected:String = "thiefsGlovesCollected"
const data_powerRingCollected:String = "powerRingCollected"

var f:functions


func _ready() -> void:
	f = functions.new()
	Events.connect("DATA_LOAD_SLOT", _on_loadSlot)
	Events.connect("DATA_SAVE_SLOT", _on_saveSlot)
	

func _getSaveData(position:Vector2) -> Dictionary:
	var data:Dictionary = {
		data_x: position.x,
		data_y: position.y,
		data_xp : Data.xp,
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
	}
	return data


func _setSaveData(data:Dictionary) -> void:
	Data.saveSpotY = data[data_y]
	Data.saveSpotX = data[data_x]
	Data.xp = data[data_xp]
	Data.lv = data[data_lv]
	Data.strength = data[data_strength]
	Data.toughness = data[data_toughness]
	Data.tailNo1Type = Enums.stringToTailType(data[data_tailNo1])
	Data.tailNo2Type = Enums.stringToTailType(data[data_tailNo2])
	Data.armor = Enums.stringToArmors(data[data_armor])
	Data.weapon = Enums.stringToWeapon(data[data_weapon])
	Data.shield = Enums.stringToShields(data[data_shield])
	Data.thiefsGlovesCollected = f.intToBool(data[data_thiefsGlovesCollected])
	Data.powerRingCollected = f.intToBool(data[data_powerRingCollected])


func _getSlotPath(slot:int) -> String:
	return path % str(slot)
	

func _on_saveSlot(slot:int, position:Vector2) -> void:
	var fileAccess:FileAccess = FileAccess.open(_getSlotPath(slot), FileAccess.WRITE)
	var data:String = JSON.stringify(_getSaveData(position))
	fileAccess.store_line(data)

func _on_loadSlot(slot:int = 1) -> void:
	if !FileAccess.file_exists(_getSlotPath(slot)):
		return
		
	var fileAccess:FileAccess = FileAccess.open(_getSlotPath(slot), FileAccess.READ)
	while fileAccess.get_position() < fileAccess.get_length():
		var text:String = fileAccess.get_line()
		var json = JSON.new()
		var e:Error = json.parse(text)
		if e == OK:
			_setSaveData(json.get_data())
		
		
		
	
