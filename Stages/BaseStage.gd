extends Node3D
class_name BaseStage

@export var active: bool = false
@export var arena_scale = 2.45

func set_active(active: bool):
	self.active = active
	
func list_columns() -> Array[int]:
	return [0, 1, 2, 3]

func get_player_column() -> int:
	# TODO: Hack, track this here instead?
	return get_parent().player_column

func get_adjacent_column(col: int) -> int:
	if col == 0:
		return 1
	var column_count = list_columns().size()
	if col == (column_count - 1):
		return column_count - 2
	var direction = randi_range(0, 1) * 2 - 1
	return col + direction
	
func get_player_adjacent_column() -> int:
	return get_adjacent_column(get_player_column())

func get_random_column() -> int:
	return randi_range(0, list_columns().size() - 1)
	
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
