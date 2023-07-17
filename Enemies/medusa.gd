extends EnemigoBase

@onready var attack_player = $pivote/attackPlayer

var damage = 10
var stop = false
func _on_attack_player_body_entered(body):
	print("Anguila electrocutó al pescador")
	animation_player.play("attack")
	body.take_damage(damage,self)
	print("terminó animacion ataque")

func contar():
	Contador.contador_medusa+=1
