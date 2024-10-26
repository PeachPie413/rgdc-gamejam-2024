extends Area2D

@onready var rng = RandomNumberGenerator.new()

# Amount soul floats up and down by
@export var floatieMult = 5
var offset


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.seed = hash(self.position)
	offset = rng.randf() * TAU
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = Time.get_ticks_msec() / 1000; # Time in seconds
	
	get_node("Sprite").offset.y = sin(time + offset) * floatieMult
	
	pass
