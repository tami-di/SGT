extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 400
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 500

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var flip_hv = $flipHV

func _physics_process(delta):
	
	print(position)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var move_input = Input.get_axis("move_left","move_right")
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION)
	
	
	
	
	#animation
	if abs(velocity.x) !=0 and move_input:
		animation_player.play("run")
		#playback.travel("run")
	else:
		#animation_player.play("idle")
		playback.travel("idle")
	
	if move_input:
		flip_hv.scale.x =  sign(move_input)
		
	move_and_slide()
