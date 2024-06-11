## Generic script for any pickable item
extends Area2D

## Signal for player when picking up item
signal picked_up

## Name of the pickable item
var _name : String = "null"

func _ready():
	# Get the name of the sprite2D node to determine item "class"
	# Took this approach to mainly avoid groups
	_name = get_child(0).get_child(0).name
	print(_name)
	# Start the animation with slight variation for each item
	await get_tree().create_timer(randf_range(0, 0.5)).timeout
	$AnimationPlayer.play("hover")


func _on_body_entered(body):
	if body is Player:
		#self.queue_free()
		self.visible = false
		picked_up.emit(self._name)
