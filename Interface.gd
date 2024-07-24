extends Control

signal column_changed(index: int)
signal shoot()

@onready var input = %TextInput
@onready var column_labels = [%FarLeft, %MidLeft, %MidRight, %FarRight]
@onready var all_labels = [%FarLeft, %MidLeft, %MidRight, %FarRight, %Shoot]
@onready var dictionary = $WordProvider

var last_good_input: String = ""

func _ready():
	DisplayServer.window_set_min_size($AspectRatioContainer.custom_minimum_size)
	input.grab_focus()
	for label in all_labels:
		update_word(label)

func _input(event):
	#$TextInput._input(event)
	pass

func _on_text_input_text_changed(text):
	var partial_match = false
	for label in all_labels:
		label.set_typed_text(text)
		var command_text = label.command_text
		if text == command_text:
			var col_index = column_labels.find(label)
			if col_index >= 0:
				column_changed.emit(col_index)
				reset(label)
				return
			if label == %Shoot:
				shoot.emit()
				reset(label)
				return
		if command_text.begins_with(text):
			partial_match = true
	if !partial_match:
		input.text = last_good_input
		input.caret_column = last_good_input.length()
		$ErrorPlayer.play()
	else:
		last_good_input = text

func reset(label: CommandLabel):
	input.text = ''
	update_word(label)

func update_word(label: CommandLabel):
	label.set_command_text(dictionary.get_new_word(list_words_in_use()))
	
func list_words_in_use() -> Array[String]:
	var in_use: Array[String] = []
	for label in all_labels:
		if label.command_text:
			in_use.append(label.command_text)
	return in_use
