class_name MainMenu extends Control


signal game_started


func start():
	game_started.emit()
	print(":3")
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var btn = get_node("Play Button") # or create a button scene instead
	btn.pressed.connect(start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
