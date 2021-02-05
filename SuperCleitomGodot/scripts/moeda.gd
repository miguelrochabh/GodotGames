extends Area2D

func _on_moedas_body_enter( body ):
	body.moeda()
	get_node("anim").play("coletar")
	get_node("shape").queue_free()
	get_node("somCoin").play()
	yield(get_node("anim"), "finished")
	queue_free()
