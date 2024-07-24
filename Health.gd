extends Node
class_name Health

signal damage_taken(amount: int)
signal health_zero()

@export var max_health: int = 10

@onready var value = max_health

func damage(amount: int) -> int:
	amount = min(amount, value)
	value -= amount
	damage_taken.emit(amount)
	if value == 0:
		health_zero.emit()
	return amount
