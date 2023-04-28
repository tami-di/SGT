extends CharacterBody2D


@export var SPEED = -110.0
const JUMP_VELOCITY = -400.0
var screen_size
var switch = 0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimationPlayer.play("movement") #Hacer referencia para más tarde
	velocity.x = SPEED

func flip():
	sprite_2d.flip_h = !sprite_2d.flip_h
	velocity.x *= -1

func _physics_process(delta):
	move_and_slide()
