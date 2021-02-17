extends Control

var play_unhovered = preload("res://assets/Menu/play.png")
var play_hovered = preload("res://assets/Menu/play-hovered.png")
var erase_unhovered = preload("res://assets/Menu/erase.png")
var erase_hovered = preload("res://assets/Menu/erase-hovered.png")

func _ready():
	 get_node("StartAnim").play("Open")

func _on_Play_pressed():
	get_node("Anim").play("Start")
	get_node("Play").set_hover_texture(play_hovered)
	get_node("Play").set_normal_texture(play_hovered)

	get_node("Erase").set_hover_texture(erase_unhovered)
	get_node("Erase").set_normal_texture(erase_unhovered)

func _on_Erase_pressed():
	pass

func _on_Anim_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/Main.tscn")
