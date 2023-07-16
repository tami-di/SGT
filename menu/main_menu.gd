extends MarginContainer
@onready var play = %Play
@onready var settings = %Settings
@onready var exit = %Exit
@onready var credits = %Credits
@onready var setting = $Settings
@onready var panel_container = $PanelContainer

func _ready():
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
	setting.hide()
	
func _on_play_pressed():
	#en res:blabla va el nombre de la escena del juego
	get_tree().change_scene_to_file("res://main.tscn")
	
func _on_settings_pressed():
	setting.visible = true
	panel_container.visible = false
	setting.get_child(2).visible = true
	setting.get_child(0).visible = false
	setting.get_child(1).visible = false

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")

	
func _on_exit_pressed():
	get_tree().quit()


func _on_settings_escondido():
	panel_container.visible = true
	setting.get_child(2).visible = false
