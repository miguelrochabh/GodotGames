extends Node2D

var pressed = preload("res://assets/botao-pressed.png")
onready var unpressed = get_node("Botao/Sprite")
onready var stagelabel = get_node("Painel/Stage")
onready var stagenumber = get_node("Painel/StageNumber")
onready var description = get_node("Painel/Description")
onready var spawn = get_node("Spawn")
var opened = false
var entered = false
var barrier_opened = false
var stage_text = ""
var stage = 0
signal finished

#Variáveis para os estágios
var flipped = false
var only_right = false

#Sinais para os estágios
signal new_stage
signal inverted_commands
signal only_right

func _ready():
	stage = 0
	flipped = false
	only_right = false
	stagelabel.set_text("Stage")
	description.set_text("Normal")
	stagenumber.text = (str(stagenumber))
	updatestage(stage)

#Indicando a mudanca em determinados estágios
func _physics_process(delta):
	updatedescription(description)
	
	if stage == 0:
		stage_text = "Normal"
	
	if stage == 1:
		flipped = true
		flip_commands()
		stage_text = "Going Flipped"

	if stage == 2:
		only_right = true
		flipped = false
		only_right()

#Morrer ao tocar no espinho
func _on_Espinho_body_entered(body):
	morrer()

#Função morrer
func morrer():
	get_node("Personagem").set_position(Vector2(17, -71))

#Função de apertar o botão
func _on_Botao_body_entered(body):
	if not barrier_opened: pass
	unpressed.set_texture(pressed)
	get_node("Botao/Sprite").set_position(Vector2(316.329, -3.989))
	if barrier_opened: return
	get_node("Barreira/Anim").play("Open")
	barrier_opened = true

#Função de sair do botão
func _on_Botao_body_exited(body):
	get_node("Botao/Sprite").set_texture(load("res://assets/botao.png"))
	get_node("Botao/Sprite").set_position(Vector2(316.329, -7.499))

#Função de dar update no número do estágio
func updatestage(stage):
	get_node("Painel/StageNumber").set_text(str(stage+1))

#Função de dar update na descrição
func updatedescription(description):
	description.set_text(stage_text)

#Função de entrar no cano do fim do estágio
func _on_Fim_body_entered(body):
	if entered: return
	emit_signal("finished")
	entered = true
	get_node("PassStage/Anim").play("Stage")
	
#Função de sair no cano do fim do estágio
func _on_Fim_body_exited(body):
	entered = false
	emit_signal("new_stage")

#Função de apertar no botão de menu
func _on_Menu_pressed():
	get_node("Start/Anim").play("Leave")
	get_tree().change_scene("res://scenes/Menu.tscn")

#Função de apertar no botão de pânico
func _on_Panic_pressed():
	morrer()
	if not barrier_opened: return
	get_node("Barreira/Anim").play_backwards("Open")
	barrier_opened = false

#Animação de mudança de estágio
func _on_Anim_animation_finished(anim_name):
	emit_signal("new_stage")
	get_node("Personagem").set_position(get_node("Spawn").get_position())
	stage = stage+1
	updatestage(stage)
	get_node("Barreira/Anim").play_backwards("Open")
	barrier_opened = false
	updatedescription(description)

#Função para o estágio 2
func flip_commands():
	emit_signal("inverted_commands")

#Função para o estágio 3
func only_right():
	flipped = false
	stage_text = "Left Arrow Is Not Working As Intended"
	emit_signal("only_right")
	print("right")
