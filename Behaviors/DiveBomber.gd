extends Behavior
class_name DiveBomber

@export var column: int = 0
@export var delay: float = 2.0

func _ready():
	var parent = get_parent()
	parent.position = Vector3(stage.get_x_for_column(column), 0, stage.get_spawn_z())
	
	set_thrust(Vector2(0, 0.1))
	var target = Vector3(stage.get_x_for_column(column), 0, stage.get_top_z())
	var tween = create_tween()
	tween.tween_property(parent, "position", target, 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
	set_thrust(Vector2(0, 0))
	
	await get_tree().create_timer(delay).timeout
	set_thrust(Vector2(0, 1))
	target = Vector3(stage.get_x_for_column(column), 0, stage.get_despawn_z())
	tween = create_tween()
	tween.tween_property(parent, "position", target, 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	#await tween.finished
