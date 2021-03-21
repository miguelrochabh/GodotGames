extends Node

onready var game = get_parent().get_parent().get_node("Main")

enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}

const valid_commands = [
	["set_stage",
		[ARG_INT] ]
]

func set_stage(stage):
	game.stage = str(stage)
	
	if int(stage) >= 1 and int(stage) <= 20:
		game.stage = stage
		return str("Sucessfuly set stage to ", stage)
	return "Stage value must be between 1 and 20"
