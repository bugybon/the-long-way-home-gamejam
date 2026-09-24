class_name CombatEntity

extends CharacterBody2D

signal health_changed(new_health:int, max_health:int)
signal died()

@export var max_health:int
var current_health:int

func take_damage(amount:int) -> void:
	if current_health <= 0:
		return
	
	current_health = max(current_health - amount, 0)
	health_changed.emit(current_health, max_health)
	
	if current_health == 0:
		die()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)

func die():
	died.emit()
	queue_free()
