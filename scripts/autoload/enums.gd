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
	TAIL
}



enum enemyType {
	JELLY
}

func tailTypeToString(type:tailType) -> String:
	match type:
		tailType.POOCH: return "pooch"
		tailType.WIZARD: return "wizard"
		tailType.THIEF: return "thief"
		tailType.ELF: return "elf"
		_: return ""
	

func enemyTypeToString(type:enemyType) -> String:
	match type:
		enemyType.JELLY: return "jelly"
		_: return ""
