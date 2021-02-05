extends Node

onready var perc = get_node("personagem")
onready var camera = get_node("dead_camera")
onready var spawn = get_node("spawn_point")
onready var point = get_node("checkpoints/checkpoint1/text")
onready var som_fim = get_node("fim/finalizado")

var vivo = true
var moedas = 0

var check = 1

signal roll

func _ready():
	get_node("trilha").play()
	get_node("checkpoints/checkpoint1/text").set_text("")
	get_node("checkpoints/checkpoint2/text").set_text("")
	get_node("checkpoints/checkpoint3/text").set_text("")
	get_node("checkpoints/checkpoint4/text").set_text("")
	get_node("checkpoints/checkpoint5/text").set_text("")
	get_node("checkpoints/checkpoint6/text").set_text("")
	get_node("checkpoints/checkpoint7/text").set_text("")
	get_node("checkpoints/checkpoint8/text").set_text("")
	get_node("checkpoints/checkpoint9/text").set_text("")

func change_camera():
	camera.set_global_pos(perc.get_node("camera").get_camera_pos())
	camera.make_current()

func _on_personagem_morreu():
	vivo = false
	change_camera()
	get_node("personagem/sprite").set_modulate(Color(1, 0, 0))
	get_node("trilha").stop()
	get_node("personagem/somMorre").play()
	
	get_node("spawn_timer").set_wait_time(5.5)
	get_node("spawn_timer").start()

func _on_spawn_timer_timeout():
	reviver()
	vivo = true

func reviver():
	perc.set_pos(get_node("spawn_point").get_pos())
	get_node("personagem/sprite").set_modulate("ffffff")
	get_node("trilha").play()
	perc.reviver()

func _on_checkpoint1_body_exit( body ):
	get_node("checkpoints/checkpoint1/text").set_text("")

func _on_checkpoint1_body_enter( body ):
	spawn.set_pos(Vector2(2420, 310))
	get_node("checkpoints/checkpoint1/text").set_text("Checkpoint")

func _on_checkpoint2_body_enter( body ):
	get_node("checkpoints/checkpoint2/text").set_text("Checkpoint")

func _on_checkpoint2_body_exit( body ):
	get_node("spawn_point").set_pos(Vector2(4921, -1400))
	get_node("checkpoints/checkpoint2/text").set_text("")

func _on_checkpoint3_body_enter( body ):
	get_node("checkpoints/checkpoint3/text").set_text("Checkpoint")

func _on_checkpoint3_body_exit( body ):
	get_node("spawn_point").set_pos(Vector2(9345, 600))
	get_node("checkpoints/checkpoint3/text").set_text("")

func _on_HotDogArea_body_enter( body ):
	perc.morrer()

func _on_HotDogArea2_body_enter( body ):
	perc.morrer()

func _on_checkpoint4_body_enter( body ):
	get_node("checkpoints/checkpoint4/text").set_text("Checkpoint")

func _on_checkpoint4_body_exit( body ):
	get_node("spawn_point").set_pos(Vector2(13753, -2500))
	get_node("checkpoints/checkpoint4/text").set_text("")

func _on_HotDogArea3_body_enter( body ):
	perc.morrer()

func _on_HotDogArea4_body_enter( body ):
	perc.morrer()

func _on_checkpoint5_body_enter( body ):
	get_node("checkpoints/checkpoint5/text").set_text("Checkpoint")

func _on_checkpoint5_body_exit( body ):
	get_node("spawn_point").set_pos(Vector2(9657, -2989))
	get_node("checkpoints/checkpoint5/text").set_text("")

func _on_HotDogArea5_body_enter( body ):
	perc.morrer()

func _on_checkpoint6_body_enter( body ):
	get_node("checkpoints/checkpoint6/text").set_text("Checkpoint")

func _on_checkpoint6_body_exit( body ):
	get_node("spawn_point").set_pos(Vector2(9790, -4180))
	get_node("checkpoints/checkpoint6/text").set_text("")

func _on_restart_pressed():
	if not vivo: return
	perc.set_pos(get_node("spawn_point").get_pos())

func _on_checkpoint7_body_enter( body ):
	get_node("checkpoints/checkpoint7/text").set_text("Checkpoint")

func _on_checkpoint7_body_exit( body ):
	get_node("spawn_point").set_pos(Vector2(20455, 511))
	get_node("checkpoints/checkpoint7/text").set_text("")

func _on_checkpoint8_body_enter( body ):
	get_node("checkpoints/checkpoint8/text").set_text("Checkpoint")

func _on_checkpoint8_body_exit( body ):
	get_node("spawn_point").set_pos(Vector2(32332, -395))
	get_node("checkpoints/checkpoint8/text").set_text("")

func _on_checkpoint9_body_enter( body ):
	get_node("checkpoints/checkpoint9/text").set_text("Checkpoint")

func _on_checkpoint9_body_exit( body ):
	get_node("spawn_point").set_pos(Vector2(47431, -259))
	get_node("checkpoints/checkpoint9/text").set_text("")

func _on_personagem_fim():
	change_camera()
	
	get_node("trilha").stop()
	som_fim.play()
	
	get_node("fim_timer").set_wait_time(6)
	get_node("fim_timer").start()
	

func _on_Rick_Roll_roll():
	get_node("trilha").stop()

func _on_fim_timer_timeout():
	get_tree().change_scene("res://scenes/obrigado.tscn")


func _on_personagem_moeda():
	moedas = moedas + 1
	get_node("canvasLayer/controles/moedasLabel").set_text(str(moedas))
