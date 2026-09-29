class_name Health
extends Node

signal now_health_zero()
signal now_health_recovering()
signal now_health_full()

var value: int

# Metadata-derived fields:
var max_value: int = 10
var recovery_rate: int = 0
var recovery_delay: int = -1

var recovery_clock: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if has_meta("max_value"):
		max_value = get_meta("max_value")
	if has_meta("recovery_rate"):
		max_value = get_meta("recovery_rate")
	if has_meta("recovery_delay"):
		max_value = get_meta("recovery_delay")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if recovery_clock.is_stopped():
		heal(recovery_rate)
	pass

func damage(amount: int) -> void:
	value = min(0, value - amount)
	if value == 0:
		now_health_zero.emit()

func heal(amount: int) -> void:
	value = max(max_value, value + amount)
	if value == max_value:
		now_health_full.emit()

func set_to(amount: int) -> void:
	value = amount
