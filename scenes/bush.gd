extends Node2D

signal player_death

# Called when the node enters the scene tree for the first time.
# Connect signal to game_manager
func _ready():
	player_death.connect(GameManager._on_player_death)


func _on_area_2d_bush_body_entered(_body):
	print_debug("signal")
	player_death.emit()
	# For some reason detects collision twice
	$Area2DBush/CollisionBush.set_deferred("disabled", true)


func _on_area_2d_glide_body_entered(body):
	if body is Player:
		if body.gliding == true:
			body.velocity.y += -200.0
