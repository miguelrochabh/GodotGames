extends Node2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func dest(sent):
	if sent == -1:
		get_node("AnimationPlayer").play("direita")
	else:
		get_node("AnimationPlayer").play("esquerda")