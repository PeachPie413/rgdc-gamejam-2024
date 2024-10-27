class_name LevelManager extends Node2D
	
var levelPaths = [
	"res://scenes/levels/level0.tscn",
	"res://scenes/levels/level1.tscn",
	"res://scenes/levels/level2.tscn"
]

var levels = []

signal to_win_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for path in levelPaths:
		levels.append(load(path) as PackedScene)
	
	load_level(0)
	pass # Replace with function body.


func load_level(index: int):
	if (index == -1):
		to_win_screen.emit()
		
	remove_all_children()
	var loadedLevel = levels[index].instantiate()
	add_child(loadedLevel)
	var exit = loadedLevel.get_node("Exit")
	exit.door_exit.connect(load_level)


# Removes all children of the node
func remove_all_children() -> void:
	for child in get_children():
		child.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
