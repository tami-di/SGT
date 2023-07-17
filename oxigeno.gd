extends MarginContainer
@onready var oxigen = $oxigen


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_sumergido(value):
	#if isSumergido:
	if oxigen.value > 0:
		oxigen.value -= value
	
	
func set_oxigeno_actual():
	if oxigen.value==0.0:
		return -1
	if oxigen.value==100:
		return -2
