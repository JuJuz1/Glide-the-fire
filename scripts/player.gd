extends CharacterBody2D

## Speed
const SPEED = 75.0
## Jump height and scale for the gravity
const JUMP_VELOCITY = -300.0
const GRAVITY_SCALE = 0.8
## Constant gravity when gliding, has to be quite large due to multiplying with delta
const GRAVITY_GLIDE = 3000.0


## Movement processing
func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta * GRAVITY_SCALE
	
	# Jumping
	if Input.is_action_just_pressed("interact") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Gliding
	if Input.is_action_pressed("interact") and not is_on_floor() and velocity.y > 0:
		velocity.y = GRAVITY_GLIDE * delta
	
	# Constant movement to the right
	velocity.x = SPEED * delta
	velocity.x = move_toward(velocity.x, SPEED, SPEED)
	
	move_and_slide()
