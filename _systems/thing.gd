extends Node

var health_value: int
var meta_name: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_value = get_meta("health_value")
	meta_name = get_meta("name")
	print("I am " + meta_name + " and hp is " + str(health_value))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
