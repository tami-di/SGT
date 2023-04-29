extends CharacterBody2D

@export var underWaterColor:= Color(0.00,0.74,1.00,1.00) #underWaterColor:Color = Color(0.00,0.74,1.00,1.00)
var SPEED = 200.0
@export var SPEED_WATER = 200.0
@export var SPEED_AIRE = 200.0
var JUMP_VELOCITY = -600.0
@export var JUMP_VELOCITY_WATER = -600.0
@export var JUMP_VELOCITY_AIRE = -600.0
var ACCELERATION = 400
@export var ACCELERATION_AIRE = 400
@export var ACCELERATION_WATER = 400
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 500
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var flip_hv = $flipHV
@onready var camera = $Camera2D

var alturaNivelAgua: int

var isSumergido = false

func sumergir():
	if isSumergido:
		return 
	JUMP_VELOCITY = JUMP_VELOCITY_WATER
	print("Se sumerge")
	isSumergido = true
	modulate = underWaterColor
	

func desumergir():
	if not isSumergido:
		return 
	JUMP_VELOCITY = JUMP_VELOCITY_AIRE
	print("Se desumerge")
	isSumergido = false
	modulate = Color.WHITE

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or isSumergido):
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
	if Input.is_action_just_pressed("attack"):
		_attack()
	
	if position.y > alturaNivelAgua:
		sumergir()
	else:
		desumergir()




func _attack():
	playback.call_deferred("travel", "attack")

func ser_camera_limits(supizq: Vector2, infder: Vector2):
	camera.limit_bottom = infder.y
	camera.limit_left = supizq.x
	camera.limit_right = infder.x
	camera.limit_top = supizq.y
	
