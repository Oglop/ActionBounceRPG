extends Node

const enemy_enemySmall = preload("res://scenes/enemies/enemySmall.tscn")
const player_tail = preload("res://scenes/player/tails/tail.tscn")
const fx_weakHit = preload("res://scenes/fx/weakHit.tscn")
const room_door = preload("res://scenes/map/door.tscn")
const room_npc = preload("res://scenes/map/npc.tscn")
const room_pushableBlock = preload("res://scenes/platforms/pushableBlock.tscn")
const room_stairs = preload("res://scenes/platforms/jumpThoughStairs1.tscn")

func getScene(type:Enums.spawnType):
	match type:
		Enums.spawnType.FX_WEAK_HIT: return fx_weakHit.instantiate()
		Enums.spawnType.ENEMY_SMALL: return enemy_enemySmall.instantiate()
		Enums.spawnType.TAIL: return player_tail.instantiate()
		Enums.spawnType.DOOR: return room_door.instantiate()
		Enums.spawnType.NPC: return room_npc.instantiate()
		Enums.spawnType.PUSHABLE_BLOCK: return room_pushableBlock.instantiate()
		Enums.spawnType.STAIRS: return room_stairs.instantiate()
		_ : return enemy_enemySmall.instantiate()

	
