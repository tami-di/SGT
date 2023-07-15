extends CanvasLayer

#Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	$Label.text=str(Contador.contador_pulpo)
	
