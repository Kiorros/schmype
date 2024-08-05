extends Node
class_name WordProvider

const special_characters = [' ', '-']

@export var word_length: int = 5
@export var allow_special_characters: bool = false

var all_words: Array[String]

func _ready():
	reload_dictionary()

#func get_random_word_selection() -> Array[String]:
	#db.query("select max(rowid) from entries")
	#var total = db.query_result[0]["max(rowid)"]
	#var bindings = [randi_range(0, total), randi_range(0, total), randi_range(0, total), randi_range(0, total), randi_range(0, total)]
	#db.query_with_bindings("select word from entries where rowid in (?, ?, ?, ?, ?)", bindings)
	#var results: Array[String] = [] 
	#for item in db.query_result: #.map(func(el): return el["word"])
		#results.append(item["word"])
	#return results

#func get_new_word(current_words: Array[String]) -> String:
	#while true:
		#var words = get_random_word_selection();
		#for word in words:
			#if get_word_valid(word, current_words):
				#return word
	#printerr("No candidate words found")
	#return ""

func get_new_word(current_words: Array[String]) -> String:
	var selection = get_random_word()
	while !get_word_valid(selection, current_words):
		selection = get_random_word()
	return selection
	
func get_random_word() -> String:
	return all_words.pick_random()
	
func get_word_valid(word: String, current_words: Array[String]) -> bool:
	for existing_word in current_words:
		if existing_word.begins_with(word) || word.begins_with(existing_word):
			return false
	return true

func reload_dictionary():
	var db = SQLite.new()
	db.path = "res://dictionary_en.db"
	db.read_only = true
	db.open_db()
	
	var bindings = [word_length]
	var query_string = "select word from entries where length(word) = ?"
	if !allow_special_characters:
		for character in special_characters:
			query_string += " and instr(word, ?) <= 0"
			bindings.append(character)
	
	db.query_with_bindings(query_string, bindings)
	var results: Array[String] = [] 
	all_words.clear()
	for item in db.query_result: #.map(func(el): return el["word"])
		all_words.append(item["word"])
	return results
	
	db.close_db()
