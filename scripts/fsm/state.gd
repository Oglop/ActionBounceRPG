extends Node
class_name state

var object
var fsm

func enter() -> void:
	pass
	
func update(_delta:float) -> void:
	pass
	
func physics_process(_delta:float) -> void:
	pass
	
func exit() -> void:
	pass
	
func change_state(next_state:String) -> void:
	fsm.change_state(next_state)
