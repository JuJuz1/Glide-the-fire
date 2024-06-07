## Game manager
extends Node

## UI node and player
var interface : Control = null
var player : CharacterBody2D = null

func _ready():
	# Set process mode to always, used for e.g. pausing the game
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	interface = get_node("/root/World/UI")
	player = get_node("/root/World/Player")


## Check for input
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


## When the player dies
func _on_player_death():
	# Position the player to the starting position and initialize all pickables, reset picked up items and collisionshapes
	#get_tree().call_group("collision", set_collision_true) for a better solution later
	var collisions = get_tree().get_nodes_in_group("collision")
	for collisionshape in collisions:
		collisionshape.set_deferred("disabled", false)
	
	player.position = player.starting_position
	player.process_mode = Node.PROCESS_MODE_DISABLED
	interface.initialize_start()


func _process(_delta):
	#print(str(player.process_mode))
	pass
