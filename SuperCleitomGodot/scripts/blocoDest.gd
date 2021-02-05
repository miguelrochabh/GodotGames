extends StaticBody2D

func destruir():
	print("destruir")
	get_node("break").play()
	get_node("sprite").queue_free()
	get_node("shape").queue_free()
	get_node("particles").set_emitting(true)