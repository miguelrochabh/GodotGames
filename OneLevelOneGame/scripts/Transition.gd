extends CanvasLayer

func _on_Anim_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/Main.tscn")
