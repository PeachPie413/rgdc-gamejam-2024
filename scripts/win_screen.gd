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
