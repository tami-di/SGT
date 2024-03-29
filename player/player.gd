extends CharacterBody2D

@export var underWaterColor:= Color(0.00,0.74,1.00,1.00) #underWaterColor:Color = Color(0.00,0.74,1.00,1.00)
var SPEED = 200.0
@export var SPEED_WATER = 100.0
@export var SPEED_AIRE = 200.0
var JUMP_VELOCITY = -600.0
@export var JUMP_VELOCITY_WATER = -600.0
@export var JUMP_VELOCITY_AIRE = -600.0
var ACCELERATION = 400
@export var ACCELERATION_AIRE = 400
@export var ACCELERATION_WATER = 100

@export var HOOK_VELOCITY= 10

@export var ROD_LENGTH= 500
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity

@export var gravityAir = 500

@export var gravityWater = 200

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var flip_hv = $flipHV
@onready var camera = $Camera2D
@onready var flipfish = $flipHV/flipfish
@onready var area_2d_fish = $flipHV/flipfish/Area2DFish
@onready var collision_fish = $flipHV/flipfish/Area2DFish/CollisionFish
@onready var hud = $CanvasLayer/HUD
@onready var audio_stream_player = $AudioStreamPlayer
@onready var attack = $attack
@onready var attack_2 = $attack2
@onready var game_over = $CanvasLayer/GameOver
@onready var oxigen=$CanvasLayer/MarginContainer
@onready var settings = $CanvasLayer/Settings



@export var damageA1 = 2

@export var damageA2 = 4

@export var health = 100 :
	set(value):
		health = value
		if health == 0:
			death()
		hud.set_health(health)
	
var boat= null
var fishing := false

var alturaNivelAgua: int

var isSumergido = false

var inBoat := false

var isAlive:= true
var fishCaught:= false 
const MAX_HEALTH= 100

@onready var sprite_2d = $flipHV/Sprite2D

var inMovement := false

func _ready():
	SPEED = SPEED_AIRE
	JUMP_VELOCITY = JUMP_VELOCITY_AIRE
	ACCELERATION = ACCELERATION_AIRE
	animation_tree.active = true
	area_2d_fish.monitoring = false
	area_2d_fish.monitorable = false
	gravity = gravityAir
	settings.visible = false
	
func sumergir():
	if isSumergido:
		return 
	JUMP_VELOCITY = JUMP_VELOCITY_WATER
	#print("Se sumerge")
	isSumergido = true
	modulate = underWaterColor
	gravity = gravityWater
	ACCELERATION=ACCELERATION_WATER
	velocity.y/=1000

func desumergir():
	if not isSumergido:
		return 
	JUMP_VELOCITY = JUMP_VELOCITY_AIRE
	#print("Se desumerge")
	isSumergido = false
	modulate = Color.WHITE
	gravity = gravityAir
	

func _input(event):
	if not isAlive:
		return 
	elif event.is_action_pressed("attack") and not inBoat:
		_attack()
		attack.play()
	elif event.is_action_pressed("fish") and inBoat and not fishing and not inMovement: 
		_fish()
	elif event.is_action_pressed("attack_2") and not inBoat:
		_attack_2()
		attack_2.play()
		

func _physics_process(delta):
	collision_fish.set_deferred("disabled",true)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if not isAlive:
		return
	if Input.is_action_just_pressed("jump") and (not is_on_floor() or isSumergido) and not fishing:
		velocity.y = JUMP_VELOCITY
	
	var move_input = Input.get_axis("move_left","move_right") if not inBoat else 0
	velocity.x = move_toward(clamp(velocity.x, 1, 70), move_input * SPEED, ACCELERATION)
	#clamp(velocity.x, 1, 575
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
			collision_fish.set_deferred("disabled",false)
			var rod_input = Input.get_axis("move_up","move_down")
			area_2d_fish.position.y = clamp(HOOK_VELOCITY*delta*rod_input + area_2d_fish.position.y,0,ROD_LENGTH)
			camera.position.y = clamp(HOOK_VELOCITY*delta*rod_input + area_2d_fish.position.y,0,ROD_LENGTH)
			if area_2d_fish.position.y == 0:
				collision_fish.set_deferred("disabled",true)
				fishing= false 
				area_2d_fish.monitoring = false
				area_2d_fish.monitorable = false
				playback.travel("idle_remar")
		if oxigen.set_oxigeno_actual() != -2:
			oxigen.set_sumergido(-0.04)
	else: 
		if abs(velocity.x) !=0 and move_input:
			playback.travel("run")
			inMovement = true
		else: 
			playback.travel("idle")
	move_and_slide()
	
	if position.y > alturaNivelAgua:
		sumergir()
	else:
		desumergir()
	if isSumergido:
		oxigen.set_sumergido(0.03)
		#oxigen.set_oxigeno_actual()
		if oxigen.set_oxigeno_actual() == -1:
			death()
		if Input.is_action_pressed("attack_2"):
			oxigen.set_sumergido(0.03)
		
func _attack():
	playback.call_deferred("travel", "attack")
func _attack_2():
	playback.call_deferred("travel", "attack_2")

func _fish():
	fishing = true
	area_2d_fish.position.y +=1
	playback.travel("fish")
	area_2d_fish.monitoring = true
	area_2d_fish.monitorable = true
	audio_stream_player.play()

func death():
	print("se murio")
	playback.call_deferred("travel", "death")
	if not isAlive:
		return
	velocity.x = 0
	isAlive = false
	game_over.visible = true

func take_damage(damage,body):
	print("recibi daño")
	health-=damage
	if health<=0:
		health=0
		death()
	else:
		knockBack(body)
func _process(delta):
	queue_redraw()

func knockBack(body):
	pass
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
	
func _fishing_end(body):
	fishCaught=false
	body.atrapado=false

#primero: bloquear al pez, mover la camara arriba
#jugador salto, altura del pez
# soltar pez y devolver control al jugador 
func _on_area_2d_fish_body_entered(body):
	body.is_atrapado(area_2d_fish.position)
	fishing= false
	fishCaught= true
	boat.exit_boat(self)
	body.player= self
	print("ta pescando")
	playback.travel("idle")
	var tween = get_tree().create_tween()
	tween.tween_property(camera,"position",Vector2.ZERO,1)
	#animacion ide
	
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",Vector2(position.x,body.position.y),2)
	tween.tween_callback(_fishing_end.bind(body)).set_delay(0.5)
	area_2d_fish.position.y = 0
	

func _on_attack_1_area_body_entered(body):
	body.take_damage(damageA1,self)


func _on_attack_2_area_body_entered(body):
	#oxigen.set_sumergido(0.02)
	body.take_damage(damageA2,self)
	
