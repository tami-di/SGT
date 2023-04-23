extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var screen_size
var switch = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	position.x-=1
	print(position)
	$AnimationPlayer.play("movement")
	move_and_slide()
