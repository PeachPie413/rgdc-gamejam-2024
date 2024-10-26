extends Sprite2D

# controls the sprite used to show which soul is currently targeted.
# Must always be a child of player


@onready var player: PlayerController




func _ready() -> void:
	player = get_parent()
	# set "up" direction for looking at stuff
	


func _process(delta: float) -> void:
	
	# if player has a targeted node, set absolute position to be the node's position
	if player.targeted_soul != null:
		# become visible and set position
		global_position = player.targeted_soul.global_position
		visible = true
		# rotate in direction of bash
		look_at(global_position + player.bash_direction)
	else:
		# hide self
		visible = false
