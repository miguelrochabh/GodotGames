extends Area2D

func pegar():
	get_node("anim").play()
	get_node("shape").queue_free()
