## Controlling the UI

extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Remove start label vanishing it slowly
func remove_start():
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	tween.tween_property($Start, "modulate:a", 0, 1.25)
	tween.tween_property($Start, "scale", Vector2(0, 0), 2)
