extends EnemigoBase

var damage = 5

func _on_attack_player_body_entered(body):
	print("Anguila electrocutó al pescador")
	getPlayBack().travel("attack")
	body.take_damage(damage,self)
	print("terminó animacion ataque")

func contar():
	print("EL PESCADO FUE RECOGIDO")
	Contador.contador_anguila +=1
