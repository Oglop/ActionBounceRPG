extends Node

const enemySmall = preload("res://scenes/enemies/enemySmall.tscn")
const tail = preload("res://scenes/player/tails/tail.tscn")

func getScene(type):
	if type == "enemySmall":
		return enemySmall.instantiate()
	if type == "tail":
		return tail.instantiate()
		
	return enemySmall.instantiate()
