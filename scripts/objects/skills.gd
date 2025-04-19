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
