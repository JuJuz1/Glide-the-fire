extends Node2D

signal player_death

# Called when the node enters the scene tree for the first time.
# Connect signal to game_manager script (autoload)
func _ready():
	player_death.connect(GameManager._on_player_death)


func _on_area_2d_body_entered(body):
	if body is Player:
		# Disable player collision
		body.set_collision_layer_value(2, false)
		player_death.emit()
	else:
		return


func _on_area_2d_2_body_entered(body):
	if body is Player:
		if body.gliding == true:
			body.velocity.y += -400.0
