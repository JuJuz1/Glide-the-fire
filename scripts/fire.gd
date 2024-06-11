## Script for fire
extends Area2D

signal player_death


func _ready():
	player_death.connect(GameManager._on_player_death)
	
	#Start the animation with slight variation for each fire
	#await get_tree().create_timer(randf_range(0, 0.25)).timeout
	$AnimatedSprite2D.play("default")


func _on_body_entered(body):
	if body is Player:
		# Disable player collision to avoid double collision
		body.set_collision_layer_value(2, false)
		player_death.emit()
