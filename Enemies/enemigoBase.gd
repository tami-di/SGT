class_name EnemigoBase

extends CharacterBody2D

@export var SPEED = 110.0
@export var SPEED_ANGRY = 150.0
@export var velMuerte = -10
@onready var attack_Player = $pivote/attackPlayer/CollisionShape2D
@onready var pivote = $pivote
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $pivote/Sprite2D
var limiteAltura: Vector2
var player
var velChill: Vector2
var velAngry: Vector2
var atrapado= false 
@export var health = 10
var isAlive: bool = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	velChill.x = SPEED
	animation_player.play("walk")
	if velChill.x < 0:
		pivote.scale.x *= -1
	$pivote/visionArea.body_entered.connect(_on_vision_area_body_entered)
	$followArea.body_exited.connect(_on_follow_area_body_exited)
func flip():
	velChill.x *= -1

func death():
	if not isAlive:
		return
	pivote.scale.y = -1
	velocity.x = 0
	velocity.y = velMuerte
	isAlive = false
	attack_Player.set_deferred()
	#animation_player.play("death")
	animation_player.stop()
	
	
	
func take_damage(damage):
	if not isAlive:
		return
	health-=damage
	prints("vida pescao:",health)
	if health <= 0:
		health=0
		
		Contador.contador += 1
		print(Contador.contador)
		death()

func angryBehavior(delta):
	var direction = global_position.direction_to(player.global_position)
	if direction.x*velAngry.x < 0:
		sprite_2d.scale.y *= -1
	velAngry = direction*SPEED_ANGRY
	velocity = velAngry
	pivote.scale.x = 1
	pivote.rotation = direction.angle()
	
func chillBehavior(delta):
	pivote.rotation = 0
	velocity = velChill
	var signoChill = sign(velChill.x)
	pivote.scale.x = signoChill if signoChill !=0 else 1
	sprite_2d.scale.y = 1
	
	
func _physics_process(delta):
	if atrapado: 
		return 
	if isAlive:
		if player:
			angryBehavior(delta)
		else:
			chillBehavior(delta)
	if global_position.y <= limiteAltura.y:
		velocity.y = clamp(velocity.y,0,SPEED_ANGRY)
	move_and_slide()

func is_atrapado(hook:Vector2): 
	atrapado = true
func _on_vision_area_body_entered(body):
	if player:
		return
	player = body
	velAngry.x = 1

func _on_follow_area_body_exited(body):
	player = null
