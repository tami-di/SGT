extends MarginContainer
@onready var play = %Play
@onready var settings = %Settings
@onready var exit = %Exit

func _ready():
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
func _on_play_pressed():
	#en res:blabla va el nombre de la escena del juego
	get_tree().change_scene_to_file("res://main.tscn")
	
func _on_settings_pressed():
	pass
	
func _on_exit_pressed():
	get_tree().quit()
