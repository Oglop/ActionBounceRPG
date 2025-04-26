extends Node

const enemy_enemySmall = preload("res://scenes/enemies/enemySmall.tscn")
const player_tail = preload("res://scenes/player/tails/tail.tscn")
const fx_weakHit = preload("res://scenes/fx/weakHit.tscn")
const fx_fireball = preload("res://scenes/fx/fireBall.tscn")
const fx_thiefKnife = preload("res://scenes/fx/thiefKnife.tscn")
const room_door = preload("res://scenes/map/door.tscn")
const room_npc = preload("res://scenes/map/npc.tscn")
const room_pushableBlock = preload("res://scenes/platforms/pushableBlock.tscn")
const room_stairs = preload("res://scenes/platforms/jumpThoughStairs1.tscn")
const room_treasure = preload("res://scenes/map/treasure.tscn")
const room_saveSpot = preload("res://scenes/platforms/saveSpot.tscn")

func getScene(type:Enums.spawnType):
	match type:
		Enums.spawnType.FX_WEAK_HIT: return fx_weakHit.instantiate()
		Enums.spawnType.FX_FIRE_BALL: return fx_fireball.instantiate()
		Enums.spawnType.FX_THIEF_KNIFE: return fx_thiefKnife.instantiate()
		Enums.spawnType.ENEMY_SMALL: return enemy_enemySmall.instantiate()
		Enums.spawnType.TAIL: return player_tail.instantiate()
		Enums.spawnType.DOOR: return room_door.instantiate()
		Enums.spawnType.NPC: return room_npc.instantiate()
		Enums.spawnType.PUSHABLE_BLOCK: return room_pushableBlock.instantiate()
		Enums.spawnType.STAIRS: return room_stairs.instantiate()
		Enums.spawnType.TREASURE: return room_treasure.instantiate()
		Enums.spawnType.SAVE_SPOT: return room_saveSpot.instantiate()
		_ : return enemy_enemySmall.instantiate()
