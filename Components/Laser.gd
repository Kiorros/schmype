extends Area3D
class_name Laser

@export var radius: float = 1.0
@export var target: Vector3 = Vector3.ONE
@export var relative_target: bool = true

func _ready():
	reposition()

func _physics_process(delta):
	reposition()

func reposition():
	var space_state = get_world_3d().direct_space_state
	var global_target = target + (global_position if relative_target else Vector3.ZERO)
	var query = PhysicsRayQueryParameters3D.create(global_position, global_target, collision_mask, [self, get_parent()])
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	
	var end = global_target if not result else result.position
	$HitParticles.emitting = !result.is_empty()
	$HitParticles.position = global_position - end
	$DamageSoundPlayer.playing = !result.is_empty()
		
	
	var length = (end - global_position).length() + 0.2
	
	#get_node("../Marker").position = end - get_node("..").position
	
	$MeshInstance3D.position = Vector3(0, 0, length / -2)
	$MeshInstance3D.scale = Vector3(radius, length / 2, 2 * radius)
	$CollisionShape3D.position = Vector3(0, 0, length / -2)
	$CollisionShape3D.shape.height = length
	$CollisionShape3D.shape.radius = 0.5 * radius
	
	look_at(end)
