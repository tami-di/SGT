extends MarginContainer

@onready var resume = %Resume
@onready var retry = %Retry
@onready var settings = %settings
@onready var exit = %Exit

signal setting

func _ready():
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	settings.pressed.connect(_on_settings_pressed)
	exit.pressed.connect(_on_exit_pressed)
	hide()

func _input(event):
#	print(event)
	if event.is_action_pressed("pause"):
		visible = !visible
		get_tree().paused = visible

func _on_resume_pressed():
	get_tree().paused = false
	hide()

func _on_retry_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_settings_pressed():
	setting.emit()
	
func _on_exit_pressed():
	get_tree().quit()

