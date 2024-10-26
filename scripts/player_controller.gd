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
var targeted_soul: Soul

# circle cast used to detect souls in range
var bash_cast: ShapeCast2D

# used to check if the player is currently bashing or not
var is_bashing: bool

# where the mouse was on the screen when bashing was started
var mouse_start_pos: Vector2

# direction the player wants to bash in
var bash_direction: Vector2

# what speed the player should be after a bash
@export var bash_speed: float




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get child nodes
	bash_cast = get_node("Bash Range")


func _process(delta: float) -> void:
	get_is_bashing()
	slow_time()
	store_mouse_start_pos()
	if is_bashing:
		get_closest_soul()
		store_bash_direction()
	apply_bash()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	set_player_velocity(delta)
	move_and_slide()





# sets the velocity of the player
func set_player_velocity(delta: float) -> void:
	
	# get horizontal input of player
	var horizontal_input = Input.get_axis("move_left", "move_right")
	if is_on_floor() or horizontal_input != 0:
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




# gets input to check if player is currently bashing or not
func get_is_bashing() -> void:
	is_bashing = Input.is_action_pressed("dash")


# slows game time if bashing
func slow_time() -> void:
	if is_bashing:
		Engine.time_scale = time_dilation
	else:
		Engine.time_scale = 1


# gets the closest soul and stores it as targeted soul (if any are in range)
func get_closest_soul() -> void:
	
	# if there are no souls in range, get rid of stored soul
	if bash_cast.get_collision_count() == 0:
		targeted_soul = null
		pass
	
	# store closest range to soul
	var closest_soul_dist: float = 10000000
	
	# iter over all collided shapes in bash range cast
	for collider_index in bash_cast.get_collision_count():
		var collider: Node = bash_cast.get_collider(collider_index)
		
		# check if collider is a soul
		var soul_dist = position.distance_squared_to((collider as Node2D).position)
		if collider is Soul and soul_dist < closest_soul_dist:
			targeted_soul = collider as Soul
			closest_soul_dist = soul_dist


# if bashing just started, store where the mouse is in the screen
func store_mouse_start_pos() -> void:
	if Input.is_action_just_pressed("dash"):
		mouse_start_pos = get_viewport().get_mouse_position()


# gets and stores the direction to bash
func store_bash_direction() -> void:
	var current_mouse_pos = get_viewport().get_mouse_position()
	bash_direction = (current_mouse_pos - mouse_start_pos).normalized()


# check if bash was released, if so then shots player in the bash direction and bash the ghost
func apply_bash() -> void:
	if Input.is_action_just_released("dash") and targeted_soul != null:
		velocity = bash_direction * bash_speed
		targeted_soul.bash()
		targeted_soul = null # stop targeting the soul
