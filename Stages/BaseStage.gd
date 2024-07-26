extends Node3D
class_name BaseStage

@export var active: bool = false
@export var arena_scale = 2.45

func set_active(active: bool):
	self.active = active
	
func get_x_for_column(col: int):
	return (col - 1.5) * arena_scale
	
func get_spawn_z():
	return -12
	
func get_top_z():
	return -8
	
func get_player_z():
	return 0
	
func get_bottom_z():
	return 2
	
func get_despawn_z():
	return 8
