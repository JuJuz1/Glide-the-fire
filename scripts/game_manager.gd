extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set process mode to always, used for e.g. pausing the game
	self.process_mode = Node.PROCESS_MODE_ALWAYS


# Check for input
func _input(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		#get_tree().reload_current_scene()
