extends BaseStage

var enemy_scene = preload("res://Enemies/ADiveBomber.tscn")

var progress_counter = 0
var order = [0, 1, 2, 3]

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
		
	var wave_type = progress_counter % 5;
	if wave_type == 4:
		for col in order:
			spawn_enemy(col)
		order.shuffle()
	else:
		spawn_enemy(order[wave_type])
	progress_counter = progress_counter + 1

func spawn_enemy(col: int):
	var enemy = enemy_scene.instantiate()
	enemy.get_node("Behavior").column = col
	enemy.get_node("Behavior").set_stage(self)
	#var initial = Vector3(get_x_for_column(col), 0, -10.5)
	#var target = initial + Vector3(0, 0, 14)
	#enemy.position = initial
	#print(enemy.monitoring)
	#print(enemy.monitorable)
	add_child(enemy)
	#var tween = create_tween()
	#tween.tween_property(enemy, "position", target, 8).set_trans(Tween.TRANS_LINEAR)
	#tween.tween_callback(enemy.queue_free)
