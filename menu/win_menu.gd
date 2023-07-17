extends MarginContainer
@onready var pescado = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var medusa = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/Label
@onready var tortuga = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer3/Label
@onready var anguila = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer4/Label
@onready var pez_linterna = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer5/Label
@onready var tiburon = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer6/Label
@onready var pulpo = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer7/Label
@onready var total = $PanelContainer/MarginContainer/VBoxContainer/total

@onready var playAgain = $PanelContainer/MarginContainer/VBoxContainer/playAgain
@onready var main_menu = $PanelContainer/MarginContainer/VBoxContainer/mainMenu


@export var pescadoValue = 10
@export var medusaValue = 200
@export var tortugaValue = 100
@export var pezLinternaValue = 50
@export var anguilaValue = 100
@export var tiburonValue = 500
@export var pulpoValue = 250

func _ready():
	playAgain.pressed.connect(_on_playAgain_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pescado.text= str(Contador.contador_pescado) + "  X  " + str(pescadoValue) + " = " + str(Contador.contador_pescado * pescadoValue)
	medusa.text= str(Contador.contador_medusa) + "  X  " + str(medusaValue) + " = " + str(Contador.contador_medusa * medusaValue)
	anguila.text = str(Contador.contador_anguila) + "  X  " + str(anguilaValue) + " = " + str(Contador.contador_anguila * anguilaValue)
	pez_linterna.text = str(Contador.contador_pez_linterna) + "  X  " + str(pezLinternaValue) + " = " + str(Contador.contador_pez_linterna * pezLinternaValue)
	tiburon.text = str(Contador.contador_tiburon) + "  X  " + str(tiburonValue) + " = " + str(Contador.contador_tiburon * tiburonValue)
	pulpo.text = str(Contador.contador_pulpo) + "  X  " + str(pulpoValue) + " = " + str(Contador.contador_pulpo * pulpoValue)
	tortuga.text = str(Contador.contador_tortuga) + "  X  " + str(tortugaValue) + " = " + str(Contador.contador_tortuga * tortugaValue)
	total.text = "Total score = " + str(getTotal())
func _on_playAgain_pressed():
	print("presionó el boton")
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
	get_tree().paused = false
	
func getTotal():
	var x1 = Contador.contador_pescado * pescadoValue
	var x2 = Contador.contador_medusa * medusaValue
	var x3 = Contador.contador_anguila * anguilaValue
	var x4 = Contador.contador_pez_linterna * pezLinternaValue
	var x5 = Contador.contador_tiburon * tiburonValue
	var x6 = Contador.contador_pulpo * pulpoValue
	var x7 = Contador.contador_tortuga * tortugaValue
	return x1+ x2 +x3 +x4+ x5 +x6 +x7
