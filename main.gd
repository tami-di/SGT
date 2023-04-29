extends Node2D
@onready var markerAgua = $Marker2D
@onready var player = $Player
@onready var camerazoom = $Player/Camera2D
@onready var camera = $Camera2D2


# Called when the node enters the scene tree for the first time.
func _ready():
	# Inicializar ambas cámaras como visibles
	camera.enabled = true
	camerazoom.enabled = false
	player.alturaNivelAgua = markerAgua.position.y
	#plaer.metodo(mark1,mark2)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if event.is_action_pressed("camara"):
		camera.enabled = !camera.enabled
		camerazoom.enabled = !camerazoom.enabled

