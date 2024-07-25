extends Node
class_name Damage

signal on_damage_dealt(amount: int, target: Node3D)

@export var value: int = 2

func _ready():
	var parent = get_node("..")
	if parent is Area3D:
		parent.area_entered.connect(_on_parent_area_entered)
		
func _on_parent_area_entered(area):
	if area.has_node("Health"):
		var target_health = area.get_node("Health")
		var dealt = target_health.damage(value)
		#print("Dealt " + str(dealt) + " damage to " + str(area))
		on_damage_dealt.emit(dealt, area)
