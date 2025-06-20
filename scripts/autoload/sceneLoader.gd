extends Node

const enemy_enemySmall = preload("res://scenes/enemies/enemySmall.tscn")
const enemy_enemyBullet = preload("res://scenes/enemies/enemyBullet.tscn")
const player_tail = preload("res://scenes/player/tails/tail.tscn")
const fx_damage_number = preload("res://scenes/fx/damageNumber.tscn")
const fx_elfArrow = preload("res://scenes/fx/elfArrow.tscn")
const fx_explosion_small = preload("res://scenes/fx/smallExplosion.tscn")
const fx_fireball = preload("res://scenes/fx/fireBall.tscn")
const fx_floor_breaking = preload("res://scenes/fx/floorBreaking.tscn")
const fx_hitGroundDust = preload("res://scenes/fx/hitGroundDust.tscn")
const fx_swordAttack = preload("res://scenes/fx/swordAttack.tscn")
const fx_swordSlash = preload("res://scenes/fx/swordSlash.tscn")
const fx_thiefKnife = preload("res://scenes/fx/thiefKnife.tscn")
const fx_weakHit = preload("res://scenes/fx/weakHit.tscn")
const room_wines_disappear = preload("res://scenes/platforms/winesDisapear.tscn")
const room_wines_appear = preload("res://scenes/platforms/winesAppera.tscn")
const room_door = preload("res://scenes/map/door.tscn")
const room_npc = preload("res://scenes/map/npc.tscn")
const room_pushableBlock = preload("res://scenes/platforms/pushableBlock.tscn")
const room_stairs = preload("res://scenes/platforms/jumpThoughStairs1.tscn")
const room_treasure = preload("res://scenes/map/treasure.tscn")
const room_saveSpot = preload("res://scenes/platforms/saveSpot.tscn")
const room_switch_wood = preload("res://scenes/map/switch.tscn")
const room_transition = preload("res://scenes/map/roomTransition.tscn")
const room_breaking_floor = preload("res://scenes/platforms/breakingFloor.tscn")
const room_spikes = preload("res://scenes/platforms/spikes.tscn")
const room_elevator = preload("res://scenes/platforms/elevator.tscn")
const room_boss_door = preload("res://scenes/platforms/bossDoor.tscn")

func getScene(type:Enums.spawnType):
	match type:
		Enums.spawnType.BOSS_DOOR: return room_boss_door.instantiate()
		Enums.spawnType.BREAKING_FLOOR: return room_breaking_floor.instantiate()
		Enums.spawnType.DOOR: return room_door.instantiate()
		Enums.spawnType.ELEVATOR: return room_elevator.instantiate()
		Enums.spawnType.ENEMY_SMALL: return enemy_enemySmall.instantiate()
		Enums.spawnType.ENEMY_BULLET: return enemy_enemyBullet.instantiate()
		Enums.spawnType.FX_BLOCK_BREAKING: return fx_floor_breaking.instantiate()
		Enums.spawnType.FX_DAMAGE_NUMBER: return fx_damage_number.instantiate()
		Enums.spawnType.FX_ELF_ARROW: return fx_elfArrow.instantiate()
		Enums.spawnType.FX_EXPLOSION_SMALL: return fx_explosion_small.instantiate()
		Enums.spawnType.FX_FIRE_BALL: return fx_fireball.instantiate()
		Enums.spawnType.FX_GROUND_HIT_DUST: return fx_hitGroundDust.instantiate()
		Enums.spawnType.FX_SWORD_ATTACK: return fx_swordAttack.instantiate()
		Enums.spawnType.FX_SWORD_SLASH: return fx_swordSlash.instantiate()
		Enums.spawnType.FX_THIEF_KNIFE: return fx_thiefKnife.instantiate()
		Enums.spawnType.FX_WEAK_HIT: return fx_weakHit.instantiate()
		Enums.spawnType.PUSHABLE_BLOCK: return room_pushableBlock.instantiate()
		Enums.spawnType.NPC: return room_npc.instantiate()
		Enums.spawnType.ROOM_TRANSÌTION: return room_transition.instantiate()
		Enums.spawnType.SAVE_SPOT: return room_saveSpot.instantiate()
		Enums.spawnType.SPIKES: return room_spikes.instantiate()
		Enums.spawnType.STAIRS: return room_stairs.instantiate()
		Enums.spawnType.SWITCH: return room_switch_wood.instantiate()
		Enums.spawnType.TAIL: return player_tail.instantiate()
		Enums.spawnType.TREASURE: return room_treasure.instantiate()
		Enums.spawnType.WINES_DISAPPEAR: return room_wines_disappear.instantiate()
		Enums.spawnType.WINES_APPEAR: return room_wines_appear.instantiate()
		
		_ : return enemy_enemySmall.instantiate()
