extends Node

var pressed = false

onready var button = get_node("mainControl/TextureButton")
onready var texture = load("res://assets/star-pressed.png")

func _on_TextureButton_pressed():
	if pressed: return
	pressed = true
	button.set_normal_texture(texture)
	get_node("starSFX").play()
	get_node("Timer").start()

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/game.tscn")