extends Node
class_name FSM

var states:Dictionary = {}
var current_state
var current_state_node
var previous_state

func _ready() -> void:
	var object = get_parent()
	for child in get_children():
		if child is state:
			states[child.name.to_lower()] = child
			child.fsm = self
			child.object = object
			
			
func update(delta):
	if !current_state: return
	current_state_node.update(delta)

	
func physics_update(delta):
	if !current_state: return
	current_state_node.physics_process(delta)


func change_state(next_state):
	if current_state:
		current_state_node.exit()
	previous_state = current_state
	current_state = next_state
	current_state_node = states[next_state]
	current_state_node.enter()
	
