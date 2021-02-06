extends Area2D

export(int) var level = 0

func _ready():
	get_node("Number").set_texture(load("res://assets/files/png/gui/Group_" + str(level) + ".png"))

func _on_Level_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		Transition.fade_to("res://scenes/Level.tscn")
