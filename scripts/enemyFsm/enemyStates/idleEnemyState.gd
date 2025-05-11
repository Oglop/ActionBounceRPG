extends enemyBaseState

@onready var f:functions = functions.new()

func _ready() -> void:
	Events.connect("PLAYER_MAKE_NOICE", _on_playerMakeNoice)
	
func enter() -> void:
	play("idle")
	if object._canShoot != null && object._canShoot != "none":
		var wait = f.getRandomFloatInRange(0.8, 1.2)
		await get_tree().create_timer(object.shootCooldown * wait)
		change_state(Statics.STATE_ENEMY_SHOOT)
	

func _on_playerMakeNoice(playerPosition:Vector2) -> void:
	if playerPosition.x > object.global_position.x:
		object.direction = -1
		object.scale.x = -1
	else:
		object.direction = 1
		object.scale.x = 1
		

func physics_process(delta: float) -> void:
	pass
