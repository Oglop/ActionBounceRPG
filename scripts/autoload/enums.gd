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

enum enemyType {
	JELLY
}

func enemyTypeToString(type:enemyType) -> String:
	if type == enemyType.JELLY:
		return "jelly"
	return ""
