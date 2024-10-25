extends Node


# [game manager]
# Script which manages the overal game flow. Attached to the main node
# loads between different game scenes, which are children of the node


var menu_scene: PackedScene = load("res://scenes/main_menu.tscn")
var game_scene: PackedScene = load("res://scenes/game_world.tscn")
var game_over_scene: PackedScene = load("res://scenes/game_over.tscn")
var jamie_scene: PackedScene = load("res://scenes/jamie_test_scene.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# load the main menu on game start
	# load_menu()
	
	# load jamie's test scene (comment this out)
	load_jamie_scene()


# Loads the mani menu scene, removing any other loaded scene
func load_menu() -> void:
	remove_all_children()
	add_child(menu_scene.instantiate())


# Loads the game scene, removing any other loaded scene
func load_game() -> void:
	remove_all_children()
	add_child(game_scene.instantiate())


# Loads the game over scene, removing any other loaded scene
func load_game_over() -> void:
	remove_all_children()
	add_child(game_over_scene.instantiate())


# Loads my test scene, dont use this scene unless you are me and testing stuff
# - Jamie
func load_jamie_scene() -> void:
	remove_all_children()
	add_child(jamie_scene.instantiate())


# Removes all children of the node
func remove_all_children() -> void:
	for child in get_children():
		child.queue_free()
