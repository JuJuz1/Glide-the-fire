## Controlling the UI
extends Control

## Pause menu panel
#var pause_menu : Control = null

func _ready():
	#pause_menu = get_node("Pause_menu")
	pass


## Remove start label vanishing it slowly
func remove_start():
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	tween.tween_property($Start, "modulate:a", 0, 1.25)
	#tween.tween_property($Start, "scale", Vector2(0, 0), 2)


## Initialize start label when respawning
func initialize_start():
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	# Very buggy
	tween.tween_property($Start, "modulate:a", 1, 0.3)
	#$Start.modulate.a = 1
	#$Start.scale = Vector2(1, 1)
