extends CharacterBody2D


@export var SPEED = -110.0
const JUMP_VELOCITY = -400.0
var screen_size
var switch = 0
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var camera = $Camera2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	screen_size = get_viewport_rect().size
	velocity.x = SPEED
	animation_player.play("movement")
func flip():
	sprite_2d.flip_h = !sprite_2d.flip_h
	velocity.x *= -1

func _physics_process(delta):
	move_and_slide()

func set_camera_limits(supizq: Vector2, infder: Vector2):
	camera.limit_bottom = infder.y
	camera.limit_left = supizq.x
	camera.limit_right = infder.x
	camera.limit_top = supizq.y
