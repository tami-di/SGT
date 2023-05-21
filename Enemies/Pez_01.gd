extends EnemigoBase

@onready var attack_player = $pivote/attackPlayer

var damage = 1

func _on_attack_player_body_entered(body):
	print("morio al pescador")
	body.take_damage(damage)
