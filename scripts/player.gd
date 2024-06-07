## Player character
extends CharacterBody2D
class_name Player

## Speed
const SPEED : int = 8000
## Jump height and scale for the gravity
const JUMP_VELOCITY : int = -300
const GRAVITY_SCALE : float = 0.8
## Constant gravity when gliding
const GRAVITY_GLIDE : int = 3500

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

var starting_position : Vector2 = Vector2(0, 0)
## For signal from bush
var in_bush : bool = false

func _ready():
	#animation.flip_h = true
	starting_position = self.global_position
	pass


## Movement processing
func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta * GRAVITY_SCALE
	
	if is_on_floor():
		animation.play("run")
		#animation.rotation = 0
	
	# Jumping
	if Input.is_action_just_pressed("interact") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.stop()
		animation.play("jump")    
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(animation, "scale", Vector2(1, 0.9), 0.05)
		tween.tween_property(animation, "scale", Vector2(1, 1), 0.05)
		#animation.rotate(PI / 20)
		get_viewport().set_input_as_handled()
	
	# Gliding
	if Input.is_action_pressed("interact") and not is_on_floor() and velocity.y > 0:
		if in_bush:
			if $Timer.is_stopped():
				$Timer.start()
			#velocity.y += -500
			print(str(Engine.get_process_frames()))
		else:
			velocity.y = GRAVITY_GLIDE * delta
	
	# Check if player is stuck
	if velocity.x == 0:
		animation.stop()
	
	# Constant movement to the right
	velocity.x = SPEED * delta
	
	move_and_slide()


func _on_bush_entered():
	in_bush = true
	print("bush")


func _on_bush_exited():
	in_bush = false
	$Timer.stop()
	print("exit")


func _on_timer_timeout():
	velocity.y += -100
