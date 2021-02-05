extends Area2D

var chave = false
onready var anim = get_node("chave1/anim")
onready var som = get_node("chave1/somChave")


func _ready():
	pass

func abre():
	if not chave: return
	get_node("StaticBody2D/shape").queue_free()
	get_node("sprite").set_opacity(0.3)

func _on_chave1_body_enter( body ):
	chave = true
	som.play()
	get_node("chave1/anim").play("pegar")
	get_node("chave1/shape").queue_free()
	abre()

