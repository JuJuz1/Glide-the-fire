extends Node

## UI node and player
var interface = null
var player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set process mode to always, used for e.g. pausing the game
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	interface = get_node("/root/World/%UI")
	player = get_node("/root/World/%Player")


# Check for input
func _input(_event):
	# PC escape
	if Input.is_action_just_pressed("pause") and player.process_mode == Node.PROCESS_MODE_INHERIT:
		get_tree().paused = not get_tree().paused
		#get_tree().reload_current_scene()
	
	# Starting the game
	# PC space
	if Input.is_action_just_pressed("interact"):
		if player.process_mode == Node.PROCESS_MODE_DISABLED:
			player.process_mode = Node.PROCESS_MODE_INHERIT
			interface.remove_start()
