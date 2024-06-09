## Generic script for any pickable item
extends Area2D

## Signal for player when picking up item
signal picked_up


func _ready():
	pass


func _on_body_entered(body):
	if body is Player:
		self.queue_free()
		picked_up.emit(self.name)
