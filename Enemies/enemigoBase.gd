class_name EnemigoBase

extends CharacterBody2D

@export var SPEED = 110.0
@export var SPEED_ANGRY = 150.0
@export var velMuerte = -50
@onready var collisionBody = $CollisionShape2D
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
var globalDelta
@onready var animationTree = $AnimationTree
@onready var playback = $AnimationTree.get("parameters/playback")
# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	velChill.x = SPEED
	animationTree.active = true
	#animation_player.play("walk")
	if velChill.x < 0:
		pivote.scale.x *= -1
	$pivote/visionArea.body_entered.connect(_on_vision_area_body_entered)
	$followArea.body_exited.connect(_on_follow_area_body_exited)

func flip():
	velChill.x *= -1

func death():
	velocity.y = velMuerte
	if not isAlive:
		return
	$pivote/attackPlayer.body_entered.disconnect(_on_attack_player_body_entered)
	chillBehavior(getDelta())
	collisionBody.set_deferred("disabled",false)
	player = null
	pivote.scale.y = -1
	velocity.x = 0
	isAlive = false
	playback.call_deferred("travel", "death")

func take_damage(damage,body):
	if not isAlive:
		return
	health-=damage
	playback.travel("hurt")
	prints("vida pescao:",health)
	if health <= 0:
		health=0
		death()
	else:
		player = body
		knockBack(body)
func knockBack(body):
	pass
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
	globalDelta = delta
	if atrapado: 
		return 
	if isAlive:
		if player:
			if player.inBoat:
				angryBehavior(delta)
			else:
				chillBehavior(delta)
		else:
			chillBehavior(delta)
	if not isAlive:
		death()
	if global_position.y <= limiteAltura.y:
		velocity.y = clamp(velocity.y,0,SPEED_ANGRY)
	move_and_slide()

func is_atrapado(hook:Vector2): 
	atrapado = true

func _on_vision_area_body_entered(body):
	if player:
		return
	if body.inBoat:
		return
	player = body
	velAngry.x = 1

func _on_follow_area_body_exited(body):
	player = null

func delete():
	queue_free()
	
func getDelta():
	return globalDelta

func getPlayBack():
	return playback

func _on_attack_player_body_entered(body):
	pass
