extends Area2D

var pisado = false
onready var text = get_node("texto")
var entrado = 1

func _ready():
	pass

func _on_portafechada_body_enter( body ):
	if entrado == 2: return
	pisado = true
	if not pisado: return
	text.set_text("Pegue a chave!")


func _on_portafechada_body_exit( body ):
	pisado = false
	text.set_text("")
	entrado = 2
