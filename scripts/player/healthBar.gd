extends ProgressBar

@onready var lblHealth = $Label

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	size.x = Data.hpMax
	
	lblHealth.text = getFormatedText()
	max_value = Data.hpMax
	min_value = 0
	value = Data.hpCurrent
	
	
func getFormatedText()-> String:
	if Data.hpCurrent == null:
		return "---"
	var prefix = ""
	var hp:String = str(Data.hpCurrent)
	
	if hp.length() == 1:
		prefix = ""
	elif hp.length() == 2:
		prefix = " "
		
	return prefix + hp
