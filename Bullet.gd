extends Node3D

func _ready():
	if $Damage:
		$Damage.on_damage_dealt.connect(_on_damage_dealt)

func _on_damage_dealt(amount, target):
	print("Bullet did some damage!")
	queue_free()
