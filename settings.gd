extends MarginContainer
@onready var play = %Play
@onready var volumen = %Volumen
@onready var exit = %Exit
@onready var credits = %Credits

func _ready():
	play.pressed.connect(_on_play_pressed)
	#volumen.pressed.connect(_on_volumen_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
func _on_play_pressed():
	#en res:blabla va el nombre de la escena del juego
	get_tree().change_scene_to_file("res://main.tscn")
	
#func _on_volumen_pressed():
#	get_tree().change_scene_to_file("res://settings.tscn")
	

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")

	
func _on_exit_pressed():
	get_tree().quit()
