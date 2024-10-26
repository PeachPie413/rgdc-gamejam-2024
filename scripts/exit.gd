extends Area2D


signal door_exit

@export var toLevel = 1
var hitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox = get_node("Hitbox")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for collider in get_overlapping_bodies():
		if collider is PlayerController:
			door_exit.emit(toLevel)
	pass
