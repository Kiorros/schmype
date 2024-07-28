extends Behavior
class_name ABossBehavior

func _ready():
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
		await get_tree().create_timer(3.0).timeout
		set_thrust(Vector2(-1, 0))
		target = Vector3(stage.get_x_for_column(2), 0, stage.get_top_z())
		tween = create_tween()
		tween.tween_property(parent, "position", target, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		await tween.finished
		set_thrust(Vector2(0, 0))
		
		await get_tree().create_timer(3.0).timeout
		set_thrust(Vector2(1, 0))
		target = Vector3(stage.get_x_for_column(1), 0, stage.get_top_z())
		tween = create_tween()
		tween.tween_property(parent, "position", target, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		await tween.finished
		set_thrust(Vector2(0, 0))
		
