extends Control

func _ready():
	get_node("anim").play("obrigado")
	get_node("timer").start()
	
func _on_timer_timeout():
	get_node("Barulho").play()