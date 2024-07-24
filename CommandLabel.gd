extends RichTextLabel
class_name CommandLabel

@export var command_text: String

var typed_text: String = ""

func set_command_text(text: String):
	command_text = text
	refresh()
	
func set_typed_text(text: String):
	typed_text = text
	refresh()
	
func refresh():
	if command_text.begins_with(typed_text):
		text = "[center][color=red]" + typed_text + "[/color]" + "[color=white]" + command_text.substr(typed_text.length()) + "[/color][/center]"
	else:
		text = "[center][color=white]" + command_text + "[/color][/center]"
