extends Node
class_name WordProvider

var db
#var words = ['a', 's', 'd', 'f', 'j', 'k', 'l', ';']

func _ready():
	db = SQLite.new()
	db.path = "res://dictionary_en.db"
	db.read_only = true
	db.open_db()

func get_random_word_selection() -> Array[String]:
	db.query("select max(rowid) from entries")
	var total = db.query_result[0]["max(rowid)"]
	var bindings = [randi_range(0, total), randi_range(0, total), randi_range(0, total), randi_range(0, total), randi_range(0, total)]
	db.query_with_bindings("select word from entries where rowid in (?, ?, ?, ?, ?)", bindings)
	var results: Array[String] = [] 
	for item in db.query_result: #.map(func(el): return el["word"])
		results.append(item["word"])
	return results

func get_new_word(current_words: Array[String]) -> String:
	while true:
		var words = get_random_word_selection();
		for word in words:
			if get_word_valid(word, current_words):
				return word
	printerr("No candidate words found")
	return ""
	
func get_word_valid(word: String, current_words: Array[String]) -> bool:
	for existing_word in current_words:
		if existing_word.begins_with(word) || word.begins_with(existing_word):
			return false
	return true
