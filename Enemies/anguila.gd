extends EnemigoBase

@onready var attack_player = $pivote/attackPlayer

var damage = 10

func _on_attack_player_body_entered(body):
	print("Anguila electrocutó al pescador")
	body.take_damage(damage)
	animation_player.play("attack")
	repose()
	print("terminó animacion ataque")
func repose():
	animation_player.play("idle")
	var i = 0
	velocity.x = 0
	velocity.y = 0
	while i < 500:
		i+=1
	velocity = velChill
	animation_player.play("walk")
	
