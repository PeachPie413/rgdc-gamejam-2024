class_name MainMenu extends CanvasLayer


signal game_started


func start_game():
	game_started.emit()
	pass


func quit_game():
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
