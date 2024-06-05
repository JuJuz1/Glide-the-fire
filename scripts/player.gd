extends CharacterBody2D

## Speed
const SPEED = 75.0
## Jump height and scale for the gravity
const JUMP_VELOCITY = -300.0
const GRAVITY_SCALE = 0.8


func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_SCALE
	
	# Handle player interaction
	if Input.is_action_just_pressed("interact") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	velocity.x = SPEED * delta
	velocity.x = move_toward(velocity.x, SPEED, SPEED)
	
	move_and_slide()
