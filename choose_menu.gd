extends MarginContainer

@onready var play_again = %playAgain
@onready var main_menu = %mainMenu


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hola")
	main_menu.pressed.connect(_on_main_menu_pressed)
	play_again.pressed.connect(_on_play_again_pressed)
	hide()



func _on_play_again_pressed():
	get_tree().paused = false
	hide()


func _on_main_menu_pressed():
	print("no seguir jugando")
	get_tree().change_scene_to_file("res://menu/win_menu.tscn")
