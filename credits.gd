extends MarginContainer
@onready var back = %back


# Called when the node enters the scene tree for the first time.
func _ready():
	back.pressed.connect(_on_back_pressed)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
