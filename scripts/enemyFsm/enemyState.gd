extends Node
class_name enemyState

var object
var enemyFsm:enemyFSM

func enter() -> void:
	pass
	
func update(_delta:float) -> void:
	pass
	
func physics_process(_delta:float) -> void:
	pass
	
func exit() -> void:
	pass
	
func change_state(next_state:String) -> void:
	enemyFsm.change_state(next_state)
