## Player character

extends CharacterBody2D

## Speed
const SPEED = 8000.0
## Jump height and scale for the gravity
const JUMP_VELOCITY = -300.0
const GRAVITY_SCALE = 0.8
## Constant gravity when gliding
const GRAVITY_GLIDE = 3000.0

@onready var animation = $AnimatedSprite2D


func _ready():
	#animation.flip_h = true
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
	
	# Gliding
	if Input.is_action_pressed("interact") and not is_on_floor() and velocity.y > 0:
		velocity.y = GRAVITY_GLIDE * delta
	
	# Check if player is stuck
	if velocity.x == 0:
		animation.stop()
	
	# Constant movement to the right
	velocity.x = SPEED * delta
	
	move_and_slide()
