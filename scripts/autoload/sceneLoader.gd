extends Node

const enemy_enemySmall = preload("res://scenes/enemies/enemySmall.tscn")
const player_tail = preload("res://scenes/player/tails/tail.tscn")
const fx_weakHit = preload("res://scenes/fx/weakHit.tscn")
const room_door = preload("res://scenes/map/door.tscn")

func getScene(type:Enums.spawnType):
	match type:
		Enums.spawnType.FX_WEAK_HIT: return fx_weakHit.instantiate()
		Enums.spawnType.ENEMY_SMALL: return enemy_enemySmall.instantiate()
		Enums.spawnType.TAIL: return player_tail.instantiate()
		Enums.spawnType.DOOR: return room_door.instantiate()
		_ : return enemy_enemySmall.instantiate()
		
