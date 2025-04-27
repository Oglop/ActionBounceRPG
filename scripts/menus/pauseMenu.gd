extends Node2D

const txtLevel:String = "Level"
const txtNext:String = "Next"
const txtXP:String = "XP"
const txtStrength:String = "Strength"
const txtToughness:String = "Toughness"
const txtDefence:String = "Defence"
const txtAttack:String = "Attack"

var col:int = 0
var row:int = 0


@onready var pointer = $PanelMain/pointer
@onready var selectedWeapon = $PanelMain/selectedWeapon
@onready var selectedArmor = $PanelMain/selectedArmor
@onready var selectedShield = $PanelMain/selectedShield

@onready var player_short_sword = $PanelMain/player_short_sword
@onready var player_knight_sword = $PanelMain/player_knight_sword
@onready var player_slayer_sword = $PanelMain/player_slayer_sword

@onready var player_power_ring = $PanelMain/player_power_ring

@onready var player_round_shield = $PanelMain/player_round_shield
@onready var player_knight_shield = $PanelMain/player_knight_shield
@onready var player_magic_shield = $PanelMain/player_magic_shield

@onready var player_leather_armor = $PanelMain/player_leather_armor
@onready var player_knight_armor = $PanelMain/player_knight_armor
@onready var player_legendary_armor = $PanelMain/player_legendary_armor

@onready var wizard_spirit_stone = $PanelMain/wizard_spirit_stone
@onready var wizard_fireball_tome = $PanelMain/wizard_fire_ball
@onready var wizard_item_three = $PanelMain/wizard_item_three

@onready var pooch_animalIcon = $PanelMain/pooch_animalIcon
@onready var pooch_diggingClaws = $PanelMain/pooch_digging_claws
@onready var pooch_item_three = $PanelMain/pooch_item3

@onready var elf_item1 = $PanelMain/elf_ancient_script
@onready var elf_item2 = $PanelMain/elf_ice_crystal
@onready var elf_item3 = $PanelMain/elf_item3

@onready var thief_candle = $PanelMain/thief_candle
@onready var thief_picklocks = $PanelMain/thief_lockpicks
@onready var thief_gloves = $PanelMain/thief_gloves

@onready var cleric_infinityKey = $PanelMain/cleric_infinity_key
@onready var cleric_healRod = $PanelMain/cleric_heal_rod
@onready var cleric_holySymbol = $PanelMain/cleric_holy_symbol

@onready var lblLv = $PanelMain/lblLevel
@onready var lblXP = $PanelMain/lblXP
@onready var lblNext = $PanelMain/lblNext
@onready var lblStr = $PanelMain/lblStrength
@onready var lblTgh = $PanelMain/lblToughness
@onready var lblAtt = $PanelMain/lblAttack
@onready var lblDef = $PanelMain/lblDefence
@onready var lblDesc = $PanelDescription/lblDescription

func _ready() -> void:
	Events.connect("ROOM_SHOW_PAUSE_MENU", _on_showPauseMenu)
	visible = false
	
func _on_showPauseMenu() -> void:
	_updateIcons()
	_updatePointerPosition()
	_updateDescriptionLabel()
	visible = true
	get_tree().paused = true
	

func _physics_process(delta: float) -> void:
	
	_getPointerInput()
	if Input.is_action_just_pressed("btn_jump"):
		visible = false
		get_tree().paused = false

func _updateIcons() -> void:
	_updateWeaponIcons()
	_updateArmorIcons()
	_updateShieldIcons()
	_updateWizardIcons()
	_updateThiefItems()
	_updateElfItems()
	_updatePoochItems()
	_updateClericItems()
	_updateLabels()
	_updatePlayerItemIcons()
	
func _getPointerInput() -> void:
	var updateInterface:bool = false
	if Input.is_action_just_pressed("btn_up"):
		if row > 0:
			row -= 1
		updateInterface = true
	if Input.is_action_just_pressed("btn_down"):
		if col >= 0 && col <= 2:
			if row < 3:
				row += 1
		elif col >= 3 && col <= 5:
			if row < 4:
				row += 1
		updateInterface = true
		
	if Input.is_action_just_pressed("btn_right"):
		if col < 4:
			col += 1
		updateInterface = true
		
	if Input.is_action_just_pressed("btn_left"):
		if col > 0:
			col -= 1
		#if col >= 0 && col <= 2 && row > 3:
		#	row = 3 
		updateInterface = true
	
	if updateInterface:
		_updatePointerPosition()
		_updateDescriptionLabel()
	
	
func _updateDescriptionLabel() -> void:
	lblDesc.text = ""
	if col == 0:
		if row == 0:
			lblDesc.text = "Short sword - power: " + str(int(Data.equipmentData["short-sword"].attack))
		elif row == 1:
			lblDesc.text = "Leather armor - defence: " + str(int(Data.equipmentData["leather-armor"].defence))
		elif row == 2:
			lblDesc.text = "Round shield - block: " + str(Data.equipmentData["round-shield"].block)
		elif row == 3:
			lblDesc.text = "Power ring"
	elif col == 1:
		if row == 0 && Data.weaponTier2Collected:
			lblDesc.text = "Knight sword - power: " + str(int(Data.equipmentData["knight-sword"].attack))
		elif row == 1 && Data.armorTier2Collected:
			lblDesc.text = "Knight armor - defence: " + str(int(Data.equipmentData["knight-armor"].defence))
		elif row == 2 && Data.shieldTier2Collected:
			lblDesc.text = "Knight shield - block: " + str(Data.equipmentData["knight-shield"].block)
	elif col == 2:
		if row == 0 && Data.weaponTier3Collected:
			lblDesc.text = "The slayer - power: " + str(int(Data.equipmentData["slayer-sword"].attack))
		elif row == 1 && Data.armorTier3Collected:
			lblDesc.text = "Legendary armor - defence: " + str(int(Data.equipmentData["legendary-armor"].defence))
		elif row == 2 && Data.shieldTier3Collected:
			lblDesc.text = "Magic shield - block: " + str(Data.equipmentData["magic-shield"].block)
	elif col == 3:
		if row == 0 && Data.spiritStoneCollected:
			lblDesc.text = "Spirit stone"
		elif row == 1 && Data.animalIconCollected:
			lblDesc.text = "Animal icon"
		elif row == 2 && Data.ancientScriptCollected:
			lblDesc.text = "Ancient script"
		elif row == 3 && Data.candleCollected:
			lblDesc.text = "Candle"
		elif row == 4 && Data.infinitySymbolCollected:
			lblDesc.text = "Infinity symbol"
	elif col == 4:
		if row == 0 && Data.fireBallTomeCollected:
			lblDesc.text = "Fire tome"
		elif row == 1 && Data.diggingClawsCollected:
			lblDesc.text = "digging claws"
		elif row == 2 && Data.iceCrystalCollected:
			lblDesc.text = "Ice crystal"
		elif row == 3 && Data.lockPicksCollected:
			lblDesc.text = "Lock picks"
		elif row == 4 && Data.healingRodCollected:
			lblDesc.text = "Healing rod"

	
	
func _updatePointerPosition() -> void:
	if col == 0:
		if row == 0:
			pointer.position = player_short_sword.position
		elif row == 1:
			pointer.position = player_leather_armor.position
		elif row == 2:
			pointer.position = player_round_shield.position
		elif row == 3:
			pointer.position = player_power_ring.position
	if col == 1:
		if row == 0:
			pointer.position = player_knight_sword.position
		elif row == 1:
			pointer.position = player_knight_armor.position
		elif row == 2:
			pointer.position = player_knight_shield.position
	if col == 2:
		if row == 0:
			pointer.position = player_slayer_sword.position
		elif row == 1:
			pointer.position = player_legendary_armor.position
		elif row == 2:
			pointer.position = player_magic_shield.position
	if col == 3:
		if row == 0:
			pointer.position = wizard_spirit_stone.position
		elif row == 1:
			pointer.position = pooch_animalIcon.position
		elif row == 2:
			pointer.position = elf_item1.position
		elif row == 3:
			pointer.position = thief_candle.position
		elif row == 4:
			pointer.position = cleric_infinityKey.position
	if col == 4:
		if row == 0:
			pointer.position = wizard_fireball_tome.position
		elif row == 1:
			pointer.position = pooch_diggingClaws.position
		elif row == 2:
			pointer.position = elf_item2.position
		elif row == 3:
			pointer.position = thief_picklocks.position
		elif row == 4:
			pointer.position = cleric_healRod.position
	if col == 5:
		if row == 0:
			pointer.position = wizard_item_three.position
		elif row == 1:
			pointer.position = pooch_item_three.position
		elif row == 2:
			pointer.position = elf_item3.position
		elif row == 3:
			pointer.position = thief_gloves.position
		elif row == 4:
			pointer.position = cleric_holySymbol.position
	
	
func _updateLabels() -> void:
	lblDesc.text = ""
	
	lblAtt.text = _textWithValue(txtAttack, Data.attack)
	lblDef.text = _textWithValue(txtDefence, Data.defence)
	lblLv.text = _textWithValue(txtLevel, Data.xp)
	lblNext.text = _textWithValue(txtNext, Data.next)
	lblStr.text = _textWithValue(txtStrength, Data.strength)
	lblTgh.text = _textWithValue(txtToughness, Data.toughness)
	lblXP.text = _textWithValue(txtXP, Data.xp)
	
	
func _textWithValue(text:String, value:int, plus:int = 0) -> String:
	const labelFormat:String = "%s: %s %s"
	var plusText:String = ""
	if plus != 0:
		plusText = "+%s" % [str(plus)]
	return labelFormat % [text, str(value), plusText]
	
	
func _updateWeaponIcons() -> void:
	if Data.weapon == Enums.weapons.NONE:
		player_short_sword.play("player_not_collected")
		player_knight_sword.play("player_not_collected")
		player_slayer_sword.play("player_not_collected")
	elif Data.weapon == Enums.weapons.SHORT:
		player_short_sword.play("player_short_sword")
		player_knight_sword.play("player_not_collected")
		player_slayer_sword.play("player_not_collected")
	elif Data.weapon == Enums.weapons.KNIGHT:
		player_short_sword.play("player_short_sword")
		player_knight_sword.play("player_knight_sword")
		player_slayer_sword.play("player_not_collected")
	elif Data.weapon == Enums.weapons.SLAYER:
		player_short_sword.play("player_short_sword")
		player_knight_sword.play("player_knight_sword")
		player_slayer_sword.play("player_slayer")
		
		
func _updatePlayerItemIcons() -> void:
	if Data.powerRingCollected:
		player_power_ring.play("player_power_ring")
	else:
		player_power_ring.play("player_not_collected")
		
		
func _updateArmorIcons() -> void:
	if Data.armor == Enums.armors.NONE:
		player_leather_armor.play("player_not_collected")
		player_knight_armor.play("player_not_collected")
		player_legendary_armor.play("player_not_collected")
	elif Data.armor == Enums.armors.LEATHER:
		player_leather_armor.play("player_leather_armor")
		player_knight_armor.play("player_not_collected")
		player_legendary_armor.play("player_not_collected")
	elif Data.armor == Enums.armors.IRON:
		player_leather_armor.play("player_leather_armor")
		player_knight_armor.play("player_knight_armor")
		player_legendary_armor.play("player_not_collected")
	elif Data.armor == Enums.armors.LEGEND:
		player_leather_armor.play("player_leather_armor")
		player_knight_armor.play("player_knight_armor")
		player_legendary_armor.play("player_legendary_armor")
		
	
func _updateShieldIcons() -> void:
	if Data.shield == Enums.shields.NONE:
		player_round_shield.play("player_not_collected")
		player_knight_shield.play("player_not_collected")
		player_magic_shield.play("player_not_collected")
	elif Data.shield == Enums.shields.ROUND:
		player_round_shield.play("player_round_shield")
		player_knight_shield.play("player_not_collected")
		player_magic_shield.play("player_not_collected")
	elif Data.shield == Enums.shields.KNIGHT:
		player_round_shield.play("player_round_shield")
		player_knight_shield.play("player_knight_shield")
		player_magic_shield.play("player_not_collected")
	elif Data.shield == Enums.shields.MAGIC:	
		player_round_shield.play("player_round_shield")
		player_knight_shield.play("player_knight_shield")
		player_magic_shield.play("player_magic_shield")
		
		
func _updateWizardIcons() -> void:
	if Data.fireBallTomeCollected:
		wizard_fireball_tome.play("wizard_fireball_tome")
	else:
		wizard_fireball_tome.play("wizard_not_collected")
		
	if Data.spiritStoneCollected:
		wizard_spirit_stone.play("wizard_spirit_stone")
	else:
		wizard_spirit_stone.play("wizard_not_collected")
		
	wizard_item_three.play("wizard_not_collected")


func _updateThiefItems() -> void:
	if Data.candleCollected:
		thief_candle.play("thief_candle")
	else:
		thief_candle.play("thief_not_collected")
		
	if Data.lockPicksCollected:
		thief_picklocks.play("thief_picklocks")
	else:
		thief_picklocks.play("thief_not_collected")
		
	if Data.thiefsGlovesCollected:
		thief_gloves.play("thief_gloves")
	else:
		thief_gloves.play("thief_not_collected")


func _updateElfItems() -> void:
	elf_item1.play("elf_not_collected")
	elf_item2.play("elf_not_collected")
	elf_item3.play("elf_not_collected")
	
	
func _updatePoochItems() -> void:
	if Data.animalIconCollected:
		pooch_animalIcon.play("pooch_animal_icon")
	else:
		pooch_animalIcon.play("pooch_not_collected")
		
	if Data.diggingClawsCollected:
		pooch_diggingClaws.play("pooch_digging_claws")
	else:
		pooch_diggingClaws.play("pooch_not_collected")
		
	pooch_item_three.play("pooch_not_collected")
		
	
func _updateClericItems() -> void:
	if Data.holySymbolCollected:
		cleric_holySymbol.play("cleric_holy_symbol")
	else:
		cleric_holySymbol.play("cleric_not_collected")
		
	if Data.healingRodCollected:
		cleric_infinityKey.play("cleric_heal_rod")
	else:
		cleric_infinityKey.play("cleric_not_collected")
		
	if Data.infinitySymbolCollected:
		cleric_healRod.play("cleric_infinity_key")
	else:
		cleric_healRod.play("cleric_not_collected")


		
		
