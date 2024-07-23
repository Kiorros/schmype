extends Control

signal column_changed(index: int)
signal shoot()

@onready var input = %TextInput
@onready var column_labels = [%FarLeft, %MidLeft, %MidRight, %FarRight]
@onready var all_labels = [%FarLeft, %MidLeft, %MidRight, %FarRight, %Shoot]
@onready var dictionary = $WordProvider

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
		if text == label.text:
			var col_index = column_labels.find(label)
			if col_index >= 0:
				column_changed.emit(col_index)
				reset(label)
				return
			if label == %Shoot:
				shoot.emit()
				reset(label)
				return
		if label.text.begins_with(text):
			partial_match = true
	if !partial_match:
		print("BLEEEEP")

func reset(label: Label):
	input.text = ''
	update_word(label)

func update_word(label: Label):
	#var available = words.duplicate()
	#available.shuffle()
	#for label in column_labels:
		#label.text = available[0]
		#available.remove_at(0)
	#shooty_words.shuffle()
	#%Shoot.text = shooty_words[0]
	label.text = dictionary.get_new_word(list_words_in_use())
	
func list_words_in_use() -> Array[String]:
	var in_use: Array[String] = []
	for label in all_labels:
		in_use.append(label.text)
	return in_use
