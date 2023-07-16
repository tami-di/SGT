extends MarginContainer

@onready var exit = %exit
@onready var retry = %retry
@onready var animation_player = $PanelContainer/MarginContainer/VBoxContainer/AnimationPlayer
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	retry.pressed.connect(_on_retry_pressed)
	exit.pressed.connect(_on_exit_pressed)
	hide()
func _process(delta):
	if visible and  i==0:
		animation_player.play("new_animation")
		i+=1
	
	
func _on_retry_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
