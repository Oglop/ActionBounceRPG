class_name Weapon

var damage:int :
	get:
		if damage == null:
			damage = 0
		return damage
	set(value):
		damage = value
		
		
var name:String :
	get:
		if name == null:
			name = ""
		return name
	set(value):
		name = value

func _init() -> void:
	pass
