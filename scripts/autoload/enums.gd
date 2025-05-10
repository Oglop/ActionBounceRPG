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
	FX_FIRE_BALL,
	FX_THIEF_KNIFE,
	FX_ELF_ARROW,
	FX_SWORD_ATTACK,
	FX_SWORD_SLASH,
	FX_GROUND_HIT_DUST,
	ENEMY_BULLET,
	ENEMY_SMALL,
	TAIL,
	DOOR,
	NPC,
	PUSHABLE_BLOCK,
	STAIRS,
	TREASURE,
	SAVE_SPOT,
	SWITCH,
	
}


enum npcType {
	INFO,
	MERCHANT,
	INN_KEEPER,
}

enum switchType {
	WOOD,
	STONE,
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


enum potionType {
	NONE,
	EMPTY,
	FULL,
}

enum cameraType {
	HORI,
	VERT,
	STILL,
	FREE,
}

func potionTypeToString(value:Enums.potionType) -> String:
	match value:
		potionType.EMPTY: return "EMPTY"
		potionType.FULL: return "FULL"
		_: return "EMPTY"
		
		
func stringToPotionType(value:String) -> potionType:
	match value:
		"EMPTY": return potionType.EMPTY
		"FULL": return potionType.FULL
		_: return Enums.potionType.NONE

func stringToCameraType(value:String) -> cameraType:
	match value:
		"hori": return cameraType.HORI
		"vert": return cameraType.VERT
		"still": return cameraType.STILL
		"free": return cameraType.FREE
		_: return cameraType.FREE


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
		armors.LEATHER: return "leather-armor"
		armors.IRON: return "knight-armor"
		armors.LEGEND: return "legendary-armor"
		_: return "none-armor"
	
	
func stringToArmors(type:String) -> armors:
	match type:
		"leather-armor": return armors.LEATHER
		"knight-armor": return armors.IRON
		"legendary-armor": return armors.LEGEND
		_: return armors.NONE


func shieldsToString(type:shields) -> String:
	match type:
		shields.ROUND: return "round-shield"
		shields.KNIGHT: return "knight-shield"
		shields.MAGIC: return "magic-shield"
		_: return "none-shield"
	
	
func stringToShields(type:String) -> shields:
	match type:
		"round-shield": return shields.ROUND
		"knight-shield": return shields.KNIGHT
		"magic-shield": return shields.MAGIC
		_: return shields.NONE


func weaponToString(type:weapons) -> String:
	match type:
		weapons.SHORT: return "short-sword"
		weapons.KNIGHT: return "knight-sword"
		weapons.SLAYER: return "slayer-sword"
		_: return "none-sword"
	
	
func stringToWeapon(type:String) -> weapons:
	match type:
		"short-sword": return weapons.SHORT
		"knight-sword": return weapons.KNIGHT
		"slayer-sword": return weapons.SLAYER
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
	
