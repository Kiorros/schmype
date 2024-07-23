extends Node3D

var bullet_scene = preload("res://Bullet.tscn")
var enemy_scene = preload("res://Enemy.tscn")

@export var arena_scale = 2.3
@export var travel_time = 0.15

var player_tween
var columns: Array[int] = [0, 1, 2, 3]

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_interface_column_changed(1)
	for col in columns:
		spawn_enemy(col)


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


func get_x_for_column(col: int):
	return (col - 1.5) * arena_scale
	

func spawn_enemy(col: int):
	var enemy = enemy_scene.instantiate()
	var initial = Vector3(get_x_for_column(col), 0, -10.5)
	var target = initial + Vector3(0, 0, 14)
	enemy.position = initial
	add_child(enemy)
	var tween = create_tween()
	tween.tween_property(enemy, "position", target, 5).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(enemy.queue_free)
	
