extends Area3D

func _ready():
	#$Health.damage_taken.connect(func(amount): print("Enemy took " + str(amount) + " damage!"))
	if $Destructible:
		$Destructible.on_destroyed.connect(_on_destroyed)

func _on_destroyed():
	$ExplosionPlayer.play()
	var timer = get_tree().create_timer(0.5)
	get_node("..").remove_child(self)
	await timer.timeout
	queue_free()

func _on_damage_on_damage_dealt(amount, target):
	$ExplosionPlayer.play()
