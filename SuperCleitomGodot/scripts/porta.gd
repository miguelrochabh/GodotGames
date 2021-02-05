extends Area2D

var chave = false
onready var anim = get_node("chave/anim")
onready var som = get_node("chave/somChave")


func _ready():
	pass

func abre():
	if not chave: return
	get_node("StaticBody2D/shape").queue_free()
	get_node("sprite").set_opacity(0.3)

func _on_chave_body_enter( body ):
	chave = true
	som.play()
	anim.play("pegar")
	get_node("chave/shape").queue_free()
	abre()
