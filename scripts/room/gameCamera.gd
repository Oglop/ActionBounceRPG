extends Camera2D

var shakeIntesnity:float = 0.0
var activeShakeTime:float = 0.0
var shakeDecay:float = 5.0
var shakeTime:float = 0.0
var shakeTimeSpeed:float = 20.0
var noise:FastNoiseLite = FastNoiseLite.new()

func _ready() -> void:
	Events.connect("CAMERA_SHAKE", _on_screenShake)

func _physics_process(delta: float) -> void:
	if activeShakeTime > 0:
		shakeTime += delta * shakeTimeSpeed
		activeShakeTime -= delta
		
		offset = Vector2(
			noise.get_noise_2d(shakeTime, 0) * shakeIntesnity,
			noise.get_noise_2d(0, shakeTime) * shakeIntesnity
		)
		
		shakeIntesnity = max(shakeIntesnity - shakeDecay * delta, 0)
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5 * delta)
		
	
func _on_screenShake(intensity:int, time:float) -> void:
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	shakeIntesnity = intensity
	activeShakeTime = time
	shakeTime = 0.0
