extends StaticBody2D


@export var SPEED = 300.0
@onready var collision_shape_bote = $Area2D/CollisionShape2D
var velocity: Vector2
var playerInBoat:= false
@onready var markerBoat = $Marker2D
var player: CharacterBody2D
@onready var boat = $Boat

func _physics_process(delta):
	if not playerInBoat:
		return
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction: #0 o 1
		boat.flip_h = direction < 0
		player.flip_hv.scale.x = sign(direction)
		velocity.x = direction * SPEED
		player.inMovement = true
	else:
		player.inMovement = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_collide(velocity*delta)
	player.position.x = markerBoat.global_position.x


func _on_area_2d_body_entered(body):
	body.position = markerBoat.global_position
	body.velocity = Vector2.ZERO
	playerInBoat = true
	body.inBoat = true
	player = body

func _on_area_2d_body_exited(body):
	playerInBoat = false
	body.inBoat = false
