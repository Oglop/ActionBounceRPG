extends ProgressBar

@onready var lblHealth = $Label

func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	lblHealth.text = getFormatedText()
	value = (Data.hpMax / 100) * Data.hpCurrent
	
	
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
