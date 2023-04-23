extends Node2D

@onready var camera = $Camera2D2
@onready var camerazoom = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Inicializar ambas cámaras como visibles
	camera.enabled = true
	camerazoom.enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

		
func _input(event):
	if event.is_action_pressed("camara"):
		camera.enabled = !camera.enabled
		camerazoom.enabled = !camerazoom.enabled
