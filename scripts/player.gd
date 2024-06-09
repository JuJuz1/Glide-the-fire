## Player character
extends CharacterBody2D
class_name Player

signal player_death

## Speed
const SPEED : int = 7000
## Jump height and scale for the gravity
const JUMP_VELOCITY : int = -300
const GRAVITY_SCALE : float = 0.8
## Constant gravity when gliding
const GRAVITY_GLIDE : int = 3500

## Time till death if staying still
const time_death : float = 2.0
## Variable for checking how long movement is stopped
var stopped : float = 0.0

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

var starting_position : Vector2 = Vector2(0, 0)
## Used with signal from bush
## Forces to glide when entering bush to gain acceleration
var in_bush : bool = false
#var gliding : bool = false

## Picked up items
var leafs : int = 0
var twigs : int = 0
var pine_cones : int = 0


func _ready():
	#animation.flip_h = true
	starting_position = self.global_position
	player_death.connect(GameManager._on_player_death)


## Movement processing
func _physics_process(delta):
	if is_on_floor():
		animation.play("run")
	
	# Jumping
	if Input.is_action_just_pressed("interact") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.stop()
		animation.play("jump")
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(animation, "scale", Vector2(1, 0.9), 0.05)
		tween.tween_property(animation, "scale", Vector2(1, 1), 0.05)
		# To not confuse with gliding
		get_viewport().set_input_as_handled()
	
	# Gliding
	if Input.is_action_pressed("interact") and not is_on_floor() and velocity.y > 0:
		animation.stop()
		animation.play("glide")
		#gliding = true
		if in_bush:
			if $Timer.is_stopped():
				$Timer.start()
			#velocity.y += -500
		else:
			velocity.y = GRAVITY_GLIDE * delta
	elif not is_on_floor(): # Add normal gravity and animation to jump
		velocity.y += get_gravity().y * delta * GRAVITY_SCALE
		animation.play("jump")
	
	# Check if player is stuck
	if velocity.x == 0:
		stopped += delta
		if stopped > time_death:
			print(stopped)
			player_death.emit()
		animation.stop()
	else:
		stopped = 0.0
	
	# Constant movement to the right
	velocity.x = SPEED * delta
	
	move_and_slide()


## Timer for accumulating upwards acceleration during gliding over bush
## ATM 0.05, working fine
## Going lower might cause issues depenging on the frame rate etc.
func _on_timer_timeout():
	# Hard to implement checking for gliding, very minor detail nonetheless
	#if gliding:
	print(str(Engine.get_process_frames()))
	velocity.y += -100


## When entering bush
func _on_bush_entered():
	in_bush = true
	print("bush")


## Exiting bush
func _on_bush_exited():
	in_bush = false
	$Timer.stop()
	print("exit")


## When any item is picked up
func _on_item_picked_up(_name : String):
	print(_name)
	match _name:
		"Leaf":
			leafs += 1
			print("Leafs: " + str(leafs))
		"Twig":
			twigs += 1
			print("Twigs: " + str(twigs))
		"Pine_cone":
			pine_cones += 1
			print("Pine_cones: " + str(pine_cones))
		_:
			print("Null item")
