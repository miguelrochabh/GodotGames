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
var stage_text = "Going Flipped"
var stage = 0

signal finished
signal new_stage
signal inverted_commands

func _ready():
	stage = 0
	stagelabel.set_text("Stage")
	description.set_text("Normal")
	stagenumber.text = (str(stagenumber))
	updatestage(stage)

func _physics_process(delta):
	if stage == 2:
		flip_commands()

func _on_Espinho_body_entered(body):
	morrer()
 
func morrer():
	get_node("Personagem").set_position(Vector2(17, -71))

func _on_Botao_body_entered(body):
	if not barrier_opened: pass
	unpressed.set_texture(pressed)
	get_node("Botao/Sprite").set_position(Vector2(316.329, -3.989))
	if barrier_opened: return
	get_node("Barreira/Anim").play("Open")
	barrier_opened = true

func _on_Botao_body_exited(body):
	get_node("Botao/Sprite").set_texture(load("res://assets/botao.png"))
	get_node("Botao/Sprite").set_position(Vector2(316.329, -7.499))

func updatestage(stage):
	get_node("Painel/StageNumber").set_text(str(stage+1))

func updatedescription(description):
	description.set_text(stage_text)

func _on_Fim_body_entered(body):
	if entered: return
	emit_signal("finished")
	entered = true
	get_node("PassStage/Anim").play("Stage")
	
func _on_Fim_body_exited(body):
	entered = false
	emit_signal("new_stage")

func _on_Menu_pressed():
	get_node("Start/Anim").play("Leave")
	get_tree().change_scene("res://scenes/Menu.tscn")

func _on_Panic_pressed():
	morrer()
	if not barrier_opened: return
	get_node("Barreira/Anim").play_backwards("Open")
	barrier_opened = false

func _on_Anim_animation_finished(anim_name):
	emit_signal("new_stage")
	get_node("Personagem").set_position(get_node("Spawn").get_position())
	stage = stage+1
	updatestage(stage)
	get_node("Barreira/Anim").play_backwards("Open")
	barrier_opened = false
	updatedescription(description)

func flip_commands():
	print("flip")
	emit_signal("inverted_commands")
