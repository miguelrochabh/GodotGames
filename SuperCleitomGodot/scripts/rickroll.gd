extends Area2D

var pisado = false

signal roll
signal jump

func roll():
	emit_signal("roll")
	get_node("RickRoll").set_pos(Vector2(-433, -199))

func _on_Rick_Roll_body_enter( body ):
	pisado = true
	emit_signal("jump")
	get_node("Back/CollisionShape2D").set_pos(Vector2(507.052002, -1.227753))

func _on_Back_body_enter( body ):
	if not pisado: return
	roll()
	get_node("RickRoll").play()
	get_node("Back/CollisionShape2D").set_pos(Vector2(100000000, 10000000))
