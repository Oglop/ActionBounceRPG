extends Node2D

@onready var player_short_sword = $Panel/player_short_sword
@onready var player_knight_sword = $Panel/player_knight_sword
@onready var player_slayer_sword = $Panel/player_slayer_sword

@onready var player_round_shield = $Panel/player_round_shield
@onready var player_knight_shield = $Panel/player_knight_shield
@onready var player_magic_shield = $Panel/player_magic_shield

@onready var player_leather_armor = $Panel/player_leather_armor
@onready var player_knight_armor = $Panel/player_knight_armor
@onready var player_legendary_armor = $Panel/player_legendary_armor

@onready var wizard_spirit_stone = $Panel/wizard_spirit_stone
@onready var wizard_fireball_tome = $Panel/wizard_fire_ball
@onready var wizard_item_three = $Panel/wizard_item_three

@onready var pooch_animalIcon = $Panel/pooch_animalIcon
@onready var pooch_diggingClaws = $Panel/pooch_digging_claws
@onready var pooch_item_three = $Panel/pooch_item3

@onready var elf_item1 = $Panel/elf_item1
@onready var elf_item2 = $Panel/elf_item2
@onready var elf_item3 = $Panel/elf_item3

@onready var thief_candle = $Panel/thief_candle
@onready var thief_picklocks = $Panel/thief_lockpicks
@onready var thief_gloves = $Panel/thief_gloves

@onready var cleric_infinityKey = $Panel/cleric_infinity_key
@onready var cleric_healRod = $Panel/cleric_heal_rod
@onready var cleric_holySymbol = $Panel/cleric_holy_symbol

func _ready() -> void:
	Events.connect("ROOM_SHOW_PAUSE_MENU", _on_showPauseMenu)
	_updateIcons()
	visible = false
	
func _on_showPauseMenu() -> void:
	_updateIcons()
	visible = true
	get_tree().paused = true
	

func _physics_process(delta: float) -> void:
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


		
		
