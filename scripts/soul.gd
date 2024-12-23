class_name Soul extends Area2D

@onready var rng = RandomNumberGenerator.new()

# Amount soul floats up and down by
@export var floatieMult = 5
var offset


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.seed = hash(self.position)
	offset = rng.randf() * TAU


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = Time.get_ticks_msec() / 1000.0; # Time in seconds
	
	get_node("Sprite").offset.y = sin(time + offset) * floatieMult


# Called from outside, tells ghost that it has been used for a bash
func bash() -> void:
	# disable collision shape and sprite, start respawn timer
	$CollisionShape2D.disabled = true
	$Sprite.visible = false
	$"Respawn Timer".start()


# respawn the soul
func respawn() -> void:
	# re-enable collsion shape and sprite
	$CollisionShape2D.disabled = false
	$Sprite.visible = true
