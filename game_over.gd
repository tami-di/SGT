extends MarginContainer

@onready var exit = %exit
@onready var retry = %retry


# Called when the node enters the scene tree for the first time.
func _ready():
	retry.pressed.connect(_on_retry_pressed)
	exit.pressed.connect(_on_exit_pressed)
	hide()

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
