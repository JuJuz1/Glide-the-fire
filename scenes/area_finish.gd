## Game finish
extends Area2D

signal player_entered

func _on_body_entered(body):
	if body is Player:
		# Disable player collision to avoid double collision
		body.set_collision_layer_value(2, false)
		player_entered.emit()
