extends Node2D

@onready var area = $Area2D
@onready var sprite = $AnimatedSprite2D
var _open:bool
var _id:String
	
func _physics_process(delta: float) -> void:
	
	if _open:
		sprite.play("open")
	else:
		sprite.play("closed")
	
	if !_open:
		if Input.is_action_just_pressed("btn_up"):
			for b:Node in area.get_overlapping_bodies():
				if b.is_in_group("player"):
					openTreasure(_id)


func setProperties(id:String) -> void:
	_id = id
	_open = isOpen()
	
func isOpen() -> bool:
	if _id == "powerRing":
		return Data.powerRingCollected
	return false
			

func openTreasure(id:String) -> void:
	if id == Statics.ID_POWER_RING && Data.powerRingCollected == false:
		Data.powerRingCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_THIEF_GLOVES && Data.thiefsGlovesCollected == false:
		Data.thiefsGlovesCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_LOCK_PICKS && Data.lockPicksCollected == false:
		Data.lockPicksCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_FIREBALL_TOME && Data.fireBallTomeCollected == false:
		Data.fireBallTomeCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_CANDLE && Data.candleCollected == false:
		Data.candleCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_SPIRIT_STONE && Data.spiritStoneCollected == false:
		Data.spiritStoneCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_INFINITY_SYMBOL && Data.infinitySymbolCollected == false:
		Data.infinitySymbolCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_ANIMAL_ICON && Data.animalIconCollected == false:
		Data.animalIconCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_DIGGING_CLAWS && Data.diggingClawsCollected == false:
		Data.diggingClawsCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_HEALING_ROD && Data.healingRodCollected == false:
		Data.healingRodCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_HOLY_SYMBOL && Data.holySymbolCollected == false:
		Data.holySymbolCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_ANCIENT_SCRIPT && Data.ancientScriptCollected == false:
		Data.ancientScriptCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_ICE_CRYSTAL && Data.iceCrystalCollected == false:
		Data.iceCrystalCollected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_SHORT_SWORD && Data.weaponTier1Collected == false:
		Data.weaponTier1Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_KNIGHT_SWORD && Data.weaponTier2Collected == false:
		Data.weaponTier2Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_SLAYER_SWORD && Data.weaponTier3Collected == false:
		Data.weaponTier3Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_LEATHER_ARMOR && Data.armorTier1Collected == false:
		Data.armorTier1Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_KNIGHT_ARMOR && Data.armorTier2Collected == false:
		Data.armorTier2Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_LEGENDARY_ARMOR && Data.armorTier3Collected == false:
		Data.armorTier3Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_ROUND_SHIELD && Data.shieldTier1Collected == false:
		Data.shieldTier1Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_KNIGHT_SHIELD && Data.shieldTier2Collected == false:
		Data.shieldTier2Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
	if id == Statics.ID_MAGIC_SHIELD && Data.shieldTier3Collected == false:
		Data.shieldTier3Collected = true
		Events.OPEN_TREASURE.emit(id)
		_open = isOpen()
