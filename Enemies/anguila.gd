extends EnemigoBase

var damage = 10

func _on_attack_player_body_entered(body):
	print("Anguila electrocutó al pescador")
	getPlayBack().travel("attack")
	body.take_damage(damage)
	print("terminó animacion ataque")
