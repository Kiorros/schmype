extends Node
class_name Damage

signal on_damage_dealt(amount: int, target: Node3D)

@export var value: int = 2

func _ready():
	var parent = get_node("..")
	if parent is Area3D:
		parent.area_entered.connect(_on_parent_area_entered)
		
func _on_parent_area_entered(area):
	#print(get_node("..").name + " entered area " + area.name)
	if area.has_node("Health"):
		var target_health = area.get_node("Health")
		var dealt = target_health.damage(value, get_parent())
		#print("Dealing " + str(value) + " (" + str(dealt) + ") damage to " + area.name)
		on_damage_dealt.emit(dealt, area)
