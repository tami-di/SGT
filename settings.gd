extends MarginContainer
@onready var volumen = %Volumen
@onready var exit = %Exit
@onready var pantalla = %pantalla

func _ready():
	#volumen.pressed.connect(_on_volumen_pressed)
	exit.pressed.connect(_on_exit_pressed)
	pantalla.pressed.connect(_on_pantalla_pressed)
	volumen.value = Contador.volumen
	hide()
#func _on_volumen_pressed():
#	get_tree().change_scene_to_file("res://settings.tscn")


func _on_exit_pressed():
	hide()


func _on_volumen_value_changed(value):
	Contador.volumen = value

func _on_pantalla_pressed2():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pantalla.pressed.disconnect(_on_pantalla_pressed2)
	pantalla.pressed.connect(_on_pantalla_pressed)
	pantalla.text = "fullscreen"

func _on_pantalla_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	pantalla.pressed.disconnect(_on_pantalla_pressed)
	pantalla.pressed.connect(_on_pantalla_pressed2)
	pantalla.text = "Window"



func _on_pausemenu_setting():
	visible = true
