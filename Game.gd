extends Node3D

var bullet_scene = preload("res://Bullet.tscn")

@export var arena_scale = 2.45
@export var travel_time = 0.15

var stage: BaseStage

var player_tween
var player_column: int = 1
var columns: Array[int] = [0, 1, 2, 3]

var game_active: bool = false


func _ready():
	set_current_stage("res://Stages/StageA.tscn")
	$Player.position = Vector3(stage.get_x_for_column(player_column), 0, 0)
	_on_player_damage_taken(0, self)
	set_active(true)

func _process(delta):
	pass

func set_active(value: bool):
	game_active = value
	if stage:
		stage.set_active(value)

func set_current_stage(path: String):
	stage = load(path).instantiate()
	stage.arena_scale = arena_scale
	stage.active = game_active
	add_child(stage)

func _on_interface_column_changed(col: int):
	if !game_active:
		return
	
	player_column = col
	if player_tween:
		player_tween.kill()
	var target = stage.get_x_for_column(col)
	var distance = abs($Player.position.x - target)
	var time = (distance / arena_scale) * travel_time
	player_tween = create_tween()
	player_tween.tween_property($Player, "position", Vector3(target, 0, 0), time)
	player_tween.set_trans(Tween.TRANS_QUART)
	player_tween.set_ease(Tween.EASE_IN)

func _on_interface_shoot():
	if !game_active:
		return
		
	var new_bullet = bullet_scene.instantiate()
	var initial = $Player.position + Vector3(0, 0, -0.5)
	var target = initial + Vector3(0, 0, -10)
	new_bullet.position = initial
	add_child(new_bullet)
	var tween = create_tween()
	tween.tween_property(new_bullet, "position", target, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(new_bullet.queue_free)
	$Player/AttackSoundPlayer.play()


func _on_player_damage_taken(amount, source):
	var health_bar = $Interface/AspectRatioContainer/Panel/HealthBar
	health_bar.max_value = $Player/Health.max_health
	health_bar.value = $Player/Health.value
	
	# If the player is collided with, also destroy the source
	#print("Player dealt " + str(amount) + " damage by " + source.name)
	if source.has_node("Health"):
		source.get_node("Health").damage(9999999, $Player)
	
func _on_health_health_zero():
	SoundManager.play_explosion()
	var game_over = load("res://GameOver.tscn").instantiate()
	add_child(game_over)
	#TODO: Pause enemies/stop spawining how waves/stop collision detection
	#$Player.set_collision_layer_value(2, false)
	game_active = false
	$Interface.commands_enabled = false

func _on_interface_command_error():
	$Player/Health.damage(1, self)
	$ErrorPlayer.play()

func _on_interface_command_key_press():
	$KeyPressPlayer.play()

func _on_active_region_area_exited(area):
	area.queue_free()
