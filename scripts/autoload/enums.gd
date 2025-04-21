extends Node

enum directions {
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
	FX_WEAK_HIT,
	ENEMY_SMALL,
	TAIL,
	DOOR,
}



enum enemyType {
	JELLY
}

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
		_: return ""
	
	
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
		_: return ""
		
		
func stringToTailType(type:String) -> tailType:
	match type:
		"pooch": return tailType.POOCH
		"wizard": return tailType.WIZARD
		"thief": return tailType.THIEF
		"elf": return tailType.ELF
		_: return tailType.NONE
	

func enemyTypeToString(type:enemyType) -> String:
	match type:
		enemyType.JELLY: return "jelly"
		_: return ""
