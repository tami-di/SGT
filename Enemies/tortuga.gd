extends EnemigoBase

@onready var attack_player = $pivote/attackPlayer

var damage = 2

func _on_attack_player_body_entered(body):
	print("mordio al pescador")
	body.take_damage(damage,self)
	animation_player.play("attack")
	print("ataque tortuga")
