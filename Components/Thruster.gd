extends Node3D
class_name Thruster

func _process(delta):
	for child in get_children():
		if child is GPUParticles3D:
			var factor = self.scale.length()
			child.process_material.scale_min = 0.1 * factor
			child.process_material.scale_max = 0.25 * factor

func get_vector() -> Vector3:
	return (Vector3(0, 0, -1) * global_transform).normalized()

func set_thrust_vector(vector: Vector3):
	set_thrust(get_vector().dot(vector))

func set_thrust(value: float):
	$GPUParticles3D.amount_ratio = clamp(value, 0.0, 1.0) 
	#$MeshInstance3D.scale = Vector3.ONE * clamp(value, 0.0, 1.0) 
