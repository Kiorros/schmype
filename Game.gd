extends Node3D

var bullet_scene = preload("res://Bullet.tscn")
var enemy_scene = preload("res://Enemy.tscn")

@export var arena_scale = 2.3
@export var travel_time = 0.15

var player_tween
var columns: Array[int] = [0, 1, 2, 3]

var progress_counter = 0
var order = columns

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_interface_column_changed(1)
	_on_health_damage_taken(0)
	
	var wave_timer = Timer.new()
	wave_timer.wait_time = 3.0
	wave_timer.one_shot = false
	wave_timer.autostart = true
	wave_timer.connect("timeout", _on_wave_timer_timeout)
	add_child(wave_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interface_column_changed(col: int):
	if player_tween:
		player_tween.kill()
	var target = get_x_for_column(col)
	var distance = abs($Player.position.x - target)
	var time = (distance / arena_scale) * travel_time
	player_tween = create_tween()
	player_tween.tween_property($Player, "position", Vector3(target, 0, 0), time)
	player_tween.set_trans(Tween.TRANS_QUART)
	player_tween.set_ease(Tween.EASE_IN)


func _on_interface_shoot():
	var new_bullet = bullet_scene.instantiate()
	var initial = $Player.position + Vector3(0, 0, -0.5)
	var target = initial + Vector3(0, 0, -10)
	new_bullet.position = initial
	add_child(new_bullet)
	var tween = create_tween()
	tween.tween_property(new_bullet, "position", target, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(new_bullet.queue_free)
	$Player/AttackSoundPlayer.play()


func _on_wave_timer_timeout():
	var wave_type = progress_counter % 5;
	if wave_type == 4:
		for col in columns:
			spawn_enemy(col)
		order.shuffle()
	else:
		spawn_enemy(order[wave_type])
	progress_counter = progress_counter + 1

func get_x_for_column(col: int):
	return (col - 1.5) * arena_scale
	

func spawn_enemy(col: int):
	var enemy = enemy_scene.instantiate()
	var initial = Vector3(get_x_for_column(col), 0, -10.5)
	var target = initial + Vector3(0, 0, 14)
	enemy.position = initial
	add_child(enemy)
	var tween = create_tween()
	tween.tween_property(enemy, "position", target, 8).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(enemy.queue_free)


func _on_health_damage_taken(amount):
	var health_bar = $Interface/AspectRatioContainer/Panel/HealthBar
	health_bar.max_value = $Player/Health.max_health
	health_bar.value = $Player/Health.value


func _on_health_health_zero():
	get_tree().paused = true
	print("GAME OVER")
