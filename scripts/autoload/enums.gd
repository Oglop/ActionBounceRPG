extends Node

enum directions {
	NONE,
	RIGHT,
	UP,
	LEFT,
	DOWN
}
enum tailType {
	NONE, 
	POOCH, 
	WIZARD, 
	ELF, 
	THIEF, 
	CLERIC, 
	DWARF
}

enum playerState {
	IDLE, 
	AIR, 
	WALKING, 
	ATTACK, 
	HURT, 
	GO_THROUGH_DOOR
}


enum spawnType {
	NONE,
	FX_WEAK_HIT,
	ENEMY_SMALL,
	TAIL,
	DOOR,
	NPC,
	PUSHABLE_BLOCK,
	STAIRS,
	TREASURE,
}


enum npcType {
	INFO,
	MERCHANT,
	INN_KEEPER,
}


enum enemyType {
	NONE,
	JELLY,
	SCORP,
	SQUID,
}


func stringToEnemyType(type:String) -> enemyType:
	match type:
		"jelly": return enemyType.JELLY
		"scorp": return enemyType.SCORP
		"squid": return enemyType.SQUID
		_ : return enemyType.NONE
		
		
func enemyTypeToString(type:enemyType) -> String:
	match type:
		enemyType.JELLY: return "jelly"
		enemyType.SCORP: return "scorp"
		enemyType.SQUID: return "squid"
		_: return ""
		

enum weapons {
	NONE,
	SHORT,
	KNIGHT,
	SLAYER
}


enum shields {
	NONE,
	ROUND,
	KNIGHT,
	MAGIC
}


enum armors {
	NONE,
	LEATHER,
	IRON,
	LEGEND
}


enum messageType {
	NONE,
	INFO,
	YES_NO
}


func stringToMessageType(type:String) -> messageType:
	match type:
		"none": return messageType.NONE
		"info": return messageType.INFO
		"yes-no": return messageType.YES_NO
		_ : return messageType.NONE 


func stringToNpcType(type:String) -> npcType:
	match type:
		"info": return npcType.INFO
		"merchant": return npcType.MERCHANT
		"innKeeper": return npcType.INN_KEEPER
		_: return npcType.INFO


func armorsToString(type:armors) -> String:
	match type:
		armors.LEATHER: return "leather"
		armors.IRON: return "iron"
		armors.LEGEND: return "legend"
		_: return ""
	
	
func stringToArmors(type:String) -> armors:
	match type:
		"leather": return armors.LEATHER
		"iron": return armors.IRON
		"legend": return armors.LEGEND
		_: return armors.NONE


func shieldsToString(type:shields) -> String:
	match type:
		shields.ROUND: return "round"
		shields.KNIGHT: return "knight"
		shields.MAGIC: return "magic"
		_: return ""
	
	
func stringToShields(type:String) -> shields:
	match type:
		"round": return shields.ROUND
		"knight": return shields.KNIGHT
		"magic": return shields.MAGIC
		_: return shields.NONE


func weaponToString(type:weapons) -> String:
	match type:
		weapons.SHORT: return "short"
		weapons.KNIGHT: return "knight"
		weapons.SLAYER: return "slayer"
		_: return "short"
	
	
func stringToWeapon(type:String) -> weapons:
	match type:
		"short": return weapons.SHORT
		"knight": return weapons.KNIGHT
		"slayer": return weapons.SLAYER
		_: return weapons.NONE


func tailTypeToString(type:tailType) -> String:
	match type:
		tailType.POOCH: return "pooch"
		tailType.WIZARD: return "wizard"
		tailType.THIEF: return "thief"
		tailType.ELF: return "elf"
		tailType.CLERIC: return "cleric"
		_: return ""
		
		
func stringToTailType(type:String) -> tailType:
	match type:
		"pooch": return tailType.POOCH
		"wizard": return tailType.WIZARD
		"thief": return tailType.THIEF
		"elf": return tailType.ELF
		"cleric": return tailType.CLERIC
		_: return tailType.NONE
	
