extends Control

onready var input_box = get_node("Input")
onready var output_box = get_node("Output")

func ready():
	input_box.grab_focus()

func process_command(text):
	var words = text.split(" ")
	words = Array(words)
	words.erase("")
	
	for i in range(words.count("")):
		words.erase("")
	
	output_text(str ("Number Of Words: ", words.size()) )
	for w in words:
		output_text(w)


func output_text(text):
	output_box.text = str(output_box.text, '\n', text)

func _on_Input_text_entered(new_text):
	input_box.clear()
	process_command(new_text)
