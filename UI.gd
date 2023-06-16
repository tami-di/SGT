extends CanvasLayer

var pezmurido = 0

func _ready():
	var enemigo = get_node("path/to/Main/enemigos/Pez_01")
	enemigo.connect("pezmuerto", self, "_on_pezmuerto_handler")

	$Label2.text = str(pezmurido)

func _on_pezmuerto_handler():
	_on_pezmuerto()

func _on_pezmuerto():
	print("pezmuerto")
	pezmurido += 1
	$Label2.text = str(pezmurido)
