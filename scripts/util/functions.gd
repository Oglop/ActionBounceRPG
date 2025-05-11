class_name functions
var rng:RandomNumberGenerator

func _init() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()

func copyDictionary(source: Dictionary) -> Dictionary:
	var copy: Dictionary = source.duplicate()
	return copy

func copyArray(source: Array) -> Array:
	var copy: Array = source.duplicate()
	return copy
	
func randomInt(from: int, to: int) -> int:
	return rng.randi_range(from, to)
	
func plusOneLimit(value: int, maximum: int) -> int:
	if value + 1 > maximum:
		return maximum
	return value + 1
	
func plusLimit(value:int, add:int, maximum:int) -> int:
	if value + add > maximum:
		return maximum
	return value + add

func minusOneLimit(value: int, minimum: int) -> int:
	if value - 1 < minimum:
		return minimum
	return value - 1
	
func minusLimit(value:int, minus:int, minimum:int) -> int:
	if value - minus < minimum:
		return minimum
	return value - minus

func chance(test: int) -> bool:
	var value = rng.randi_range(0, 100)
	if value <= test:
		return true
	return false
	
func choose(array:Array):
	array.shuffle()
	return array.front()
	
func boolToInt(value:bool) -> int:
	if value:
		return 1
	return 0
	
func intToBool(value:int) -> bool:
	if value > 0:
		return true
	return false
	
func randomIntInRange(from:int, to:int) -> int:
	return rng.randi_range(from, to)
	
func getRandomStringFromArray(arr:Array) -> String:
	return arr[rng.randi_range(0, arr.size() - 1)]
	
func getRandomFloatInRange(from:float, to:float) -> float:
	return rng.randf_range(from, to)
	
func generateObjectId() -> String:
	var id:String = ""
	const characters:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	for i in range(10):
		id += characters.substr(rng.randi_range(0, characters.length() - 1), 1)
	return id
