extends Node2D

@onready var player = $Player
@onready var camerazoom = player.camera
@onready var supizq = $margenes/supizq
@onready var infder = $margenes/infder
@onready var markerAgua = $markerAgua
@onready var pez_01 = $Pez_01



# Called when the node enters the scene tree for the first time.
func _ready():
	# Inicializar ambas cámaras como visibles
	camerazoom.enabled = true
	player.alturaNivelAgua = markerAgua.position.y
	player.set_camera_limits(supizq.position,infder.position)
	pez_01.set_camera_limits(supizq.position,infder.position)
	prints("supizq:",supizq.position,"infder:",infder.position)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if event.is_action_pressed("camara"):
		camerazoom.enabled = !camerazoom.enabled
	if event.is_action_pressed("pez_pov"):
		pez_01.camera.enabled = !pez_01.camera.enabled

