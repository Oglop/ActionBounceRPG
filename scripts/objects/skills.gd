class_name skills

var canPickLocks:bool:
	get:
		return (Data.tailNo1Type == Enums.tailType.THIEF || Data.tailNo2Type == Enums.tailType.THIEF) && Data.thiefsGlovesCollected

var canTalkToAnimals:bool:
	get:
		return (Data.tailNo1Type == Enums.tailType.POOCH || Data.tailNo2Type == Enums.tailType.POOCH)
		
var canPushBlocks:bool:
	get:
		return Data.powerRingCollected
		
var canFindPathInForest:bool:
	get:
		return (Data.tailNo1Type == Enums.tailType.ELF || Data.tailNo2Type == Enums.tailType.ELF)
		
var canSeeSpiritDoors:bool:
	get:
		return (Data.tailNo1Type == Enums.tailType.WIZARD || Data.tailNo2Type == Enums.tailType.WIZARD) && Data.spiritStoneCollected
		
var canCastFireBalls:bool:
	get:
		return (Data.tailNo1Type == Enums.tailType.WIZARD || Data.tailNo2Type == Enums.tailType.WIZARD) && Data.fireBallTomeCollected

var canLightUpDarkness:bool:
	get:
		return (Data.tailNo1Type == Enums.tailType.THIEF || Data.tailNo2Type == Enums.tailType.THIEF) && Data.candleCollected

var canSolveInfinityPuzzle:bool:
	get:
		return (Data.tailNo1Type == Enums.tailType.CLERIC || Data.tailNo2Type == Enums.tailType.CLERIC) && Data.infinitySymbolCollected
