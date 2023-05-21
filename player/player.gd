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

@export var HOOK_VELOCITY= 10

@export var ROD_LENGTH= 500
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 500
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var flip_hv = $flipHV
@onready var camera = $Camera2D
@onready var flipfish = $flipHV/flipfish
@onready var area_2d_fish = $flipHV/flipfish/Area2DFish
@onready var collision_fish = $flipHV/flipfish/Area2DFish/CollisionFish


var fishing := false

var alturaNivelAgua: int

var isSumergido = false

var inBoat := false


@onready var sprite_2d = $flipHV/Sprite2D

var inMovement := false

func _ready():
	SPEED = SPEED_AIRE
	JUMP_VELOCITY = JUMP_VELOCITY_AIRE
	ACCELERATION = ACCELERATION_AIRE
	animation_tree.active = true
	
func sumergir():
	if isSumergido:
		return 
	JUMP_VELOCITY = JUMP_VELOCITY_WATER
	#print("Se sumerge")
	isSumergido = true
	modulate = underWaterColor
	

func desumergir():
	if not isSumergido:
		return 
	JUMP_VELOCITY = JUMP_VELOCITY_AIRE
	#print("Se desumerge")
	isSumergido = false
	modulate = Color.WHITE

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or isSumergido) and not fishing:
		velocity.y = JUMP_VELOCITY
	
	var move_input = Input.get_axis("move_left","move_right") if not inBoat else 0
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION)
	
	#animation
	
	if move_input:
		flip_hv.scale.x =  sign(move_input)
	#prints(inBoat,inMovement)
	if inBoat:
		if inMovement:
			playback.travel("remar")
		elif not fishing:
			playback.travel("idle_remar")
		else: 
			var rod_input = Input.get_axis("move_up","move_down")
			area_2d_fish.position.y = clamp(HOOK_VELOCITY*delta*rod_input + area_2d_fish.position.y,0,ROD_LENGTH)
			camera.position.y = clamp(HOOK_VELOCITY*delta*rod_input + area_2d_fish.position.y,0,ROD_LENGTH)
			if area_2d_fish.position.y == 0: 
				fishing= false 
				playback.travel("idle_remar")
	else: 
		if abs(velocity.x) !=0 and move_input:
			playback.travel("run")
			inMovement = true
		else: 
			playback.travel("idle")
	move_and_slide()
	if Input.is_action_just_pressed("attack") and not inBoat:
		_attack()
	
	if Input.is_action_just_pressed("fish") and inBoat and not fishing and not inMovement: 
		_fish()
	if Input.is_action_just_pressed("attack_2"):
		_attack_2()
	
	if position.y > alturaNivelAgua:
		sumergir()
	else:
		desumergir()
	
	
		

func _attack():
	playback.call_deferred("travel", "attack")
func _attack_2():
	playback.call_deferred("travel", "attack_2")	
func _fish():
	fishing = true
	area_2d_fish.position.y +=1
	playback.travel("fish")
	


func _process(delta):
	queue_redraw()

func _draw():
	if fishing: 
		var fish= flipfish.position* flip_hv.scale.x
		var areaf= fish + area_2d_fish.position
		
		draw_line(fish,areaf,Color.DIM_GRAY,2.0)


func set_camera_limits(supizq: Vector2, infder: Vector2):
	camera.limit_bottom = infder.y
	camera.limit_left = supizq.x
	camera.limit_right = infder.x
	camera.limit_top = supizq.y
	


func _on_area_2d_fish_body_entered(body):
	print("sii")
	pass # Replace with function body.
