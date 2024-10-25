extends CharacterBody2D


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




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
