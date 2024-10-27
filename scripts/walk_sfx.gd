extends AudioStreamPlayer2D

@onready var player: PlayerController = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# if player is walking, play sound
	# otherwise, dont play sound
	if player.is_walking:
		volume_db = -2
	else:
		volume_db = -1000
