extends CenterContainer

var game = preload("res://Game.tscn")
var game_ready = false
var advance = false

func _ready():
	await get_tree().create_timer(0.1).timeout
	game_ready = true

func _process(delta):
	if game_ready && advance:
		start_game()

func _input(event):
	if !(event is InputEventMouseMotion):
		advance = true
	
func start_game():
	get_tree().change_scene_to_packed(game)
