extends Node2D

signal player_death

signal bush_entered
signal bush_exited

# Called when the node enters the scene tree for the first time.
# Connect signal to game_manager script (autoload)
func _ready():
	player_death.connect(GameManager._on_player_death)


func _on_area_2d_fire_body_entered(body):
	if body is Player:
		# Disable player collision to avoid double collision
		body.set_collision_layer_value(2, false)
		player_death.emit()


func _on_area_2d_glide_body_entered(body):
	if body is Player:
		bush_entered.emit()


func _on_area_2d_glide_body_exited(body):
	if body is Player:
		bush_exited.emit()
