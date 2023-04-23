extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var screen_size
var switch = 0
var k = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	position.x-=k
	print(position)
	if position.x <= 0:
		$Sprite2D.flip_h = true
		k= k*-1
	if position.x >= 512:
		$Sprite2D.flip_h = false
		k= k*-1
	$AnimationPlayer.play("movement")
	move_and_slide()
