class_name SpeedrunTimer extends CanvasLayer


var timer: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	
	var currentTime = timer
	
	var mills: int = floor(fmod(currentTime, 1.0) * 1000)
	currentTime = floor(currentTime)
	var secs: int = fmod(currentTime, 60.0)
	currentTime /= 60.0
	currentTime = floor(currentTime)
	var mins = currentTime
	
	var timeDisplay: String = ""
	if mins < 10:
		timeDisplay += "0"
	timeDisplay += str(mins) + ":"
	
	if secs < 10:
		timeDisplay += "0"
	timeDisplay += str(secs) + "."
	
	if mills < 100:
		timeDisplay += "0"
	if mills < 10:
		timeDisplay += "0"
	timeDisplay += str(mills)
	
	
	get_node("Label").text = timeDisplay
	pass
