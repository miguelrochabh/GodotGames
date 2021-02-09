extends Node2D

func _ready():
	pass
	
func _on_Espinho_body_entered(body):
	morrer()

func morrer():
	get_node("Personagem").set_position(Vector2(17, -71))
