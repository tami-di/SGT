extends EnemigoBase

@onready var attack_player = $pivote/attackPlayer

var damage = 10

func _on_attack_player_body_entered(body):
	print("Anguila electrocutó al pescador")
	body.take_damage(damage)
	animation_player.play("attack")




func _on_attack_player_body_exited(body):
	pass # Replace with function body.
