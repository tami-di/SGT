extends Node2D

@onready var player = $Player
@onready var camerazoom = player.camera
@onready var supizq = $margenes/supizq
@onready var infder = $margenes/infder
@onready var markerAgua = $markerAgua
@onready var enemigos = $enemigos
@onready var win_state = $winState
@onready var win_menu = $CanvasLayer/win_menu



# Called when the node enters the scene tree for the first time.
func _ready():
	Contador.restart()
	# Inicializar ambas cámaras como visibles
	camerazoom.enabled = true
	player.alturaNivelAgua = markerAgua.position.y
	player.set_camera_limits(supizq.position,infder.position)
	prints("supizq:",supizq.position,"infder:",infder.position)
	for enemigo in enemigos.get_children():
		enemigo.limiteAltura = markerAgua.global_position	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	if player.inBoat:
		win_state.get_child(0).set_deferred("disabled",false)

func _input(event):
	if event.is_action_pressed("camara"):
		camerazoom.enabled = !camerazoom.enabled

func _on_win_state_body_entered(body):
	get_tree().paused = true
	win_menu.visible = true
	


