extends Node2D

var pressed = preload("res://assets/botao-pressed.png")
onready var unpressed = get_node("Botao/Sprite")
onready var stagelabel = get_node("Painel/Stage")
onready var stagenumber = get_node("Painel/StageNumber")
var opened = false
var stage = 0
var entered = false

signal finished

func _ready():
	stage = 0
	stagelabel.set_text("Stage")
	stagenumber.text = (str(stagenumber))
	updatestage(stage)

func _on_Espinho_body_entered(body):
	morrer()
 
func morrer():
	get_node("Personagem").set_position(Vector2(17, -71))

func _on_Botao_body_entered(body):
	unpressed.set_texture(pressed)
	get_node("Botao/Sprite").set_position(Vector2(316.329, -3.989))
	if not opened:
		opened = true
		get_node("Barreira/Anim").play("Open")

func _on_Botao_body_exited(body):
	get_node("Botao/Sprite").set_texture(load("res://assets/botao.png"))
	get_node("Botao/Sprite").set_position(Vector2(316.329, -7.499))

func updatestage(stage):
	get_node("Painel/StageNumber").set_text(str(stage+1))

func _on_Fim_body_entered(body):
	if entered: return
	emit_signal("finished")
	entered = true
	stage = stage+1
	updatestage(stage)
