class_name PlayerController extends CharacterBody2D


# Move speed of the player in the horizontal direction
@export var horizontal_move_speed: float

# maximum speed the player can fall (terminal velocity)
@export var terminal_velocity: float
# acceleration of the player when they are going up
@export var upwards_gravity: float
# acceleraton of the player when they are going down
@export var downwards_velocity: float

# how fast the player jumps up (their initial velocity)
@export var jump_force: float

# how much to slow time by when dashing
@export var time_dilation: float


# the soul which is currently the closest to the player
var targeted_soul: Node2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	slow_time()
	get_closest_soul()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	set_player_velocity(delta)
	move_and_slide()




# sets the velocity of the player
func set_player_velocity(delta: float) -> void:
	
	# get horizontal input of player
	var horizontal_input = Input.get_axis("move_left", "move_right")
	velocity.x = horizontal_input * horizontal_move_speed
	
	# have the player fall
	if velocity.y < 0:
		velocity.y += upwards_gravity * delta
	else:
		velocity.y += downwards_velocity * delta
	velocity.y = max(velocity.y, -terminal_velocity)
	
	# jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force




# slows game time if input is pressed
func slow_time() -> void:
	if Input.is_action_pressed("dash"):
		Engine.time_scale = time_dilation
	else:
		Engine.time_scale = 1


# gets the closest soul and stores it as targeted soul (if any are in range)
func get_closest_soul() -> void:
	targeted_soul = self as Node2D
