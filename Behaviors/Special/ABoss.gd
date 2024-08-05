extends Behavior
class_name ABossBehavior

var laser_beam = preload("res://Components/Laser.tscn")

func start():
	var parent = get_parent()
	parent.position = Vector3(0, 0, stage.get_spawn_z())
	print(parent.position)
	
	set_thrust(Vector2(0, 0.1))
	var target = Vector3(0, 0, stage.get_top_z())
	var tween = create_tween()
	tween.tween_property(parent, "position", target, 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
	set_thrust(Vector2(0, 0))
	
	while true:
		await get_tree().create_timer(1.0).timeout
		set_thrust(Vector2(-1, 0))
		target = Vector3(stage.get_x_for_column(2), 0, stage.get_top_z())
		tween = create_tween()
		tween.tween_property(parent, "position", target, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		await tween.finished
		set_thrust(Vector2(0, 0))
		
		await fire_laserbeam()
		
		await get_tree().create_timer(1.0).timeout
		set_thrust(Vector2(1, 0))
		target = Vector3(stage.get_x_for_column(1), 0, stage.get_top_z())
		tween = create_tween()
		tween.tween_property(parent, "position", target, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		await tween.finished
		set_thrust(Vector2(0, 0))
		
		await fire_laserbeam()
		
func fire_laserbeam():
	await get_tree().create_timer(1.0).timeout
	
	get_parent().get_node("LaserSound").play()
	var laser = get_parent().get_node("LaserBuildup")
	var tween = create_tween()
	tween.tween_property(laser, 'scale', Vector3.ONE * 0.75, 0.5).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	
	var beam = laser_beam.instantiate()
	#beam.collision_mask = get_parent().collision_mask
	#beam.collision_layer = get_parent().collision_layer
	beam.radius = 0.25
	beam.position = laser.position
	beam.target = laser.position + Vector3(0, 0, 5.0)
	get_parent().add_child(beam)
	
	laser.scale = Vector3.ZERO
	await get_tree().create_timer(0.5).timeout
	beam.queue_free()
	
	return get_tree().create_timer(1.0).timeout
	
