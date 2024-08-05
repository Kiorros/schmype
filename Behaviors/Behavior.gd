extends Node
class_name Behavior

@export var stage: BaseStage

# Track position delta so we van get velocity while tweening for movement
#@onready var last_position: Vector3 = get_parent().position

func start():
	pass

func pause():
	pass

func resume():
	pass
	
func set_stage(stage: BaseStage):
	self.stage = stage

func set_thrust(vector: Vector2):
	for sibling in get_parent().get_children():
		if sibling is Thruster:
			sibling.set_thrust_vector(Vector3(vector.x, 0, vector.y))
	
#func _process(delta):
	#if get_parent() is Node3D:
		#last_position = get_parent().position
#
#func get_velocity() -> Vector3:
	#return get_parent().position - last_position
