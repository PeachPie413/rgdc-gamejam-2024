extends Node2D

var levelPaths = [
	"res://scenes/levels/level0.tscn"
]

var levels = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for path in levelPaths:
		levels.append(load(path) as PackedScene)
	
	load_level(0)
	pass # Replace with function body.


func load_level(index: int):
	remove_all_children()
	add_child(levels[0].instantiate())


# Removes all children of the node
func remove_all_children() -> void:
	for child in get_children():
		child.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
