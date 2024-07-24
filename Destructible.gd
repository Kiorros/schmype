extends Node
class_name Destructible

signal on_destroyed()

func _ready():
	var health = get_node("../Health")
	if health:
		health.health_zero.connect(_on_parent_health_zero)

func _on_parent_health_zero():
	on_destroyed.emit()
