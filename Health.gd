extends Node
class_name Health

signal damage_taken(amount: int, source: Node3D)
signal health_zero()

@export var max_health: int = 10

@onready var value = max_health

func damage(amount: int, source: Node3D) -> int:
	#print(get_parent().name + " took " + str(amount) + " damage")
	amount = min(amount, value)
	value -= amount
	damage_taken.emit(amount, source)
	if value == 0:
		health_zero.emit()
	return amount
