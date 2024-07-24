extends Area3D

func _ready():
	#$Health.damage_taken.connect(func(amount): print("Enemy took " + str(amount) + " damage!"))
	if $Destructible:
		$Destructible.on_destroyed.connect(_on_destroyed)

func _on_destroyed():
	print("BOOM! EXPLOSIONS!")
	queue_free()
