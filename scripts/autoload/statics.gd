extends Node

const ROOM_TEMPLATE:String = "res://scenes/game/rooms/templateRoom.tscn"

const LEVEL_DATA:String = "res://scripts/dataFiles/levelData.txt"
const ENEMY_DATA:String = "res://scripts/dataFiles/enemyData.txt"
const EQUIPMENT_DATA:String = "res://scripts/dataFiles/equipmentData.txt"
const LEVEL_MAX:int = 3
const TAIL_SIZE:int = 40

const GRAVITY:int = 900
const JUMP_GRAVITY:float = 900.0
const FALL_GRAVITY:float = 400.0
const TERMINAL_GRAVITY:float = 180.0

const PLAYER_SPEED_SLOW:int = 110
const PLAYER_JUMP_STRENGTH_WEAK:int = 260
const PLAYER_ACCELERATION:float = 900
const PLAYER_AIR_MULTIPLYER:float = 0.7

const STATE_IDLE:String = "idle"
const STATE_WALK:String = "walk"
const STATE_FALL:String = "fall"
const STATE_JUMP:String = "jump"

const STATE_ENEMY_IDLE:String = "idleenemystate"
const STATE_ENEMY_AIR:String = "airenemystate"
const STATE_ENEMY_DIE:String = "dieenemystate"
const STATE_ENEMY_WALK:String = "walkenemystate"
const STATE_ENEMY_BOUNCE:String = "bounceenemystate"

const BOUNCE_DIFF:int = 5
const CRITICAL_BOUNCE_BONUS:int = 10
const SMALL_BOUNCE:int = 60
const MEDIUM_BOUNCE:int = 100
const BIG_BOUNCE:int = 140

const ENEMY_SMALL_BOUNCE:int = 100
const ENEMY_MEDIUM_BOUNCE:int = 200
const ENEMY_BIG_BOUNCE:int = 300

const SWORD_DAGGER:String = "dagger"
const SWORD_SHORT_SWORD:String = "short-sword"

const SHOES_SANDALS:String = "sandals"
const SHOES_LEATHER_SHOES:String = "leather-shoes"
