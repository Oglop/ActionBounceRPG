class_name skills

var canPickLocks:bool:
	get:
		return _joinedBy(Enums.tailType.THIEF) && Data.thiefsGlovesCollected

var canTalkToAnimals:bool:
	get:
		return _joinedBy(Enums.tailType.POOCH) && Data.animalIconCollected
		
var canPushBlocks:bool:
	get:
		return Data.powerRingCollected
		
var canFindPathInForest:bool:
	get:
		return _joinedBy(Enums.tailType.ELF)
		
var canSeeSpiritDoors:bool:
	get:
		return _joinedBy(Enums.tailType.WIZARD) && Data.spiritStoneCollected
		
var canCastFireBalls:bool:
	get:
		return _joinedBy(Enums.tailType.WIZARD) && Data.fireBallTomeCollected

var canLightUpDarkness:bool:
	get:
		return _joinedBy(Enums.tailType.THIEF) && Data.candleCollected

var canSolveInfinityPuzzle:bool:
	get:
		return _joinedBy(Enums.tailType.CLERIC) && Data.infinitySymbolCollected
		
		
func _joinedBy(type:Enums.tailType) -> bool:
	return Data.tailNo1Type == type || Data.tailNo2Type == type
