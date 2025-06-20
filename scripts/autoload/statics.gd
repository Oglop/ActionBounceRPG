extends Node

const ROOM_TEMPLATE:String = "res://scenes/game/rooms/templateRoom.tscn"
const ROOM_GAME_START:String = "res://scenes/game/start.tscn"
const ROOM_START_SCREEN:String = "res://scenes/game/rooms/startRoom.tscn"

const LEVEL_DATA:String = "res://scripts/dataFiles/levelData.txt"
const ENEMY_DATA:String = "res://scripts/dataFiles/enemyData.txt"
const EQUIPMENT_DATA:String = "res://scripts/dataFiles/equipmentData.txt"
const ROOM_DATA:String = "res://scripts/dataFiles/roomData.txt"
const NPC_DATA:String = "res://scripts/dataFiles/npcData.txt"
const TEXT_DATA:String = "res://scripts/dataFiles/textData.txt"
const QUEST_DATA:String = "res://scripts/dataFiles/questData.txt"
const LEVEL_MAX:int = 6
const TAIL_SIZE:int = 40
const TAIL_POSITON_1:int = 1
const TAIL_INDEX_1:int = 7
const TAIL_POSITON_2:int = 2
const TAIL_INDEX_2:int = 15

const BOSS_TREE_CENTIPEDE := "centipede"

const GRAVITY:int = 900
const JUMP_GRAVITY:float = 900.0
const FALL_GRAVITY:float = 400.0
const TERMINAL_GRAVITY:float = 180.0

const PLAYER_SPEED_SLOW:int = 110
const PLAYER_JUMP_STRENGTH_WEAK:int = 260
const PLAYER_ACCELERATION:float = 900
const PLAYER_AIR_MULTIPLYER:float = 0.7
const PLAYER_CRITICAL_MULTIPLYER:float = 1.4

const CHARACTER_WIZARD_NAME:String = "Sevio"
const CHARACTER_POOCH_NAME:String = "Pooch"
const CHARACTER_ELF_NAME:String = "Fenro"
const CHARACTER_THIEF_NAME:String = "Rona"
const CHARACTER_CLERIC_NAME:String = "Esma"

const STATE_IDLE:String = "idle"
const STATE_WALK:String = "walk"
const STATE_FALL:String = "fall"
const STATE_JUMP:String = "jump"

const STATE_ENEMY_IDLE:String = "idleenemystate"
const STATE_ENEMY_AIR:String = "airenemystate"
const STATE_ENEMY_DIE:String = "dieenemystate"
const STATE_ENEMY_WALK:String = "walkenemystate"
const STATE_ENEMY_BOUNCE:String = "bounceenemystate"
const STATE_ENEMY_SHOOT:String = "shootenemystate"

const PLATFORM_PUSHABLE_BLOCK:String = "pushable-block"
const PLATFORM_STAIRS:String = "stairs"
const PLATFORM_SAVE_SPOT:String = "save-spot"
const PLATFORM_WINES_DISAPPEAR:String = "wines-disappear"
const PLATFORM_WINES_APPEAR:String = "wines-sappear"
const PLATFORM_BREAKING_FLOOR:String = "breaking-floor"
const PLATFORM_SPIKES:String = "spikes"
const PLATFORM_ELEVATOR:String = "elevator"
const PLATFORM_BOSS_DOOR:String = "boss-door"

const ROOM_BACKGROUND_SKY:String = "background-0001"
const ROOM_BACKGROUND_BLACK:String = "background-0002"
const ROOM_BACKGROUND_GOLDEN_FOREST:String = "background-0003"

const BOUNCE_DIFF:int = 5
const CRITICAL_BOUNCE_BONUS:int = 10
const SMALL_BOUNCE:int = 80
const MEDIUM_BOUNCE:int = 120
const BIG_BOUNCE:int = 160

const ENEMY_SMALL_BOUNCE:int = 100
const ENEMY_MEDIUM_BOUNCE:int = 200
const ENEMY_BIG_BOUNCE:int = 300

const SWORD_DAGGER:String = "dagger"
const SWORD_SHORT_SWORD:String = "short-sword"

const SHOES_SANDALS:String = "sandals"
const SHOES_LEATHER_SHOES:String = "leather-shoes"

const SKILL_FIRBALL_COST:int = 4
const SKILL_THIEF_KNIFE_COST:int = 1
const SKILL_ELF_ARROW_COST:int = 2
const SKILL_CLERIC_HEAL_COST:int = 3

const SFX_PLAYER_BOUNCE:String = "player-bounce"
const SFX_PLAYER_JUMP:String = "player-jump"
const SFX_PLAYER_BLOCK_BULLET:String = "player-block-bullet"
const SFX_PLAYER_SWITH:String = "player-switch"
const SFX_PLAYER_PASS_DOOR:String = "player-pass-door"


const ID_POWER_RING:String = "power-ring"
const ID_THIEF_GLOVES:String = "thief-gloves"
const ID_LOCK_PICKS:String = "lock-picks"
const ID_FIREBALL_TOME:String = "fireball-tome"
const ID_CANDLE:String = "candle"
const ID_SPIRIT_STONE:String = "spirit-stone"
const ID_INFINITY_SYMBOL:String = "infinity-symbol"
const ID_ANIMAL_ICON:String = "animal-icon"
const ID_DIGGING_CLAWS:String = "digging-claws"
const ID_HEALING_ROD:String = "healing-rod"
const ID_HOLY_SYMBOL:String = "holy-symbol"
const ID_ANCIENT_SCRIPT:String = "ancient-script"
const ID_ICE_CRYSTAL:String = "ice-crystal"
const ID_SHORT_SWORD:String = "short-sword"
const ID_KNIGHT_SWORD:String = "knight-sword"
const ID_SLAYER_SWORD:String = "slayer-sword"
const ID_LEATHER_ARMOR:String = "leather-armor"
const ID_KNIGHT_ARMOR:String = "knight-armor"
const ID_LEGENDARY_ARMOR:String = "legendary-armor"
const ID_ROUND_SHIELD:String = "round-shield"
const ID_KNIGHT_SHIELD:String = "knight-shield"
const ID_MAGIC_SHIELD:String = "magic-shield"
const ID_POTION:String = "potion"
