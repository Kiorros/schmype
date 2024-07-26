extends Area3D

func _ready():
	if $Damage:
		$Damage.on_damage_dealt.connect(_on_damage_dealt)

func _on_damage_dealt(amount, target):
	queue_free()
