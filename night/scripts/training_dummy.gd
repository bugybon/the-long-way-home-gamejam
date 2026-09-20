extends CombatEntity

func _ready() -> void:
	current_health = 1

func take_damage(amount:int) -> void:
	print(amount)
