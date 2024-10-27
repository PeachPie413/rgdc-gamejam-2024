class_name WinScreen extends CanvasLayer


signal to_main_menu


func _ready() -> void:
	# hide self
	visible = false
	# try to connect to level manager
	var level_manager = get_parent().get_node("LevelManager")
	if level_manager is LevelManager:
		level_manager.to_win_screen.connect(show_win_screen)


func load_main_menu():
	to_main_menu.emit()


func show_win_screen():
	visible = true
	var time_label: Label = get_node("Content/VBoxContainer/TimeText")
	var timer: SpeedrunTimer = get_parent().get_node("Timer")
	var currentTime = timer.timer
	
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
	time_label.text = timeDisplay
	timer.visible = false
