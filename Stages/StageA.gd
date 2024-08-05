extends BaseStage

var dive_bomber_scene = preload("res://Enemies/ADiveBomber.tscn")
var boss_scene = preload("res://Enemies/ABoss.tscn")

var progress_counter = 0
#var order = [0, 1, 2, 3]

func _ready():
	var wave_timer = Timer.new()
	wave_timer.wait_time = 5.0
	wave_timer.one_shot = false
	wave_timer.autostart = true
	wave_timer.connect("timeout", _on_wave_timer_timeout)
	add_child(wave_timer)
	
func _on_wave_timer_timeout():
	if !active:
		return
	
	match progress_counter:
		0: spawn_boss()
		#0: spawn_enemy(get_player_adjacent_column())
		#1: spawn_enemy(get_player_adjacent_column())
		#_ when progress_counter < 20:
			#var wave_type = (progress_counter - 2) % 5;
			#if wave_type == 4:
				#for col in list_columns():
					#spawn_enemy(col)
			#elif wave_type % 2 == 0:
				#spawn_enemy(get_player_adjacent_column())
				#spawn_enemy(get_player_column())
			#else:
				#var col = get_random_column()
				#spawn_enemy(col)
				#spawn_enemy(get_adjacent_column(col))
			
	progress_counter = progress_counter + 1
	
func spawn_boss():
	var enemy = boss_scene.instantiate()
	enemy.get_node("Behavior").set_stage(self)
	add_child(enemy)
	enemy.get_node("Behavior").start()

func spawn_enemy(col: int):
	var enemy = dive_bomber_scene.instantiate()
	enemy.get_node("Behavior").column = col
	enemy.get_node("Behavior").set_stage(self)
	add_child(enemy)
	enemy.get_node("Behavior").start()
