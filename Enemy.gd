extends Area3D
class_name Enemy

func _ready():
	#$Health.damage_taken.connect(func(amount): print("Enemy took " + str(amount) + " damage!"))
	if $Destructible:
		$Destructible.on_destroyed.connect(_on_destroyed)

func _on_destroyed():
	SoundManager.play_explosion()
	queue_free()
