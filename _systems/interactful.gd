class_name InteractionArea2D
extends Area2D

var can_interact: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_interact:
		print("can interact")
		if Input.is_action_just_pressed("interact"):
			print("VERY INTERACTIVE GAME!")
	pass

func _on_area_entered(area: Area2D) -> void:
	print("yes")
	if area.get_parent().has_meta("the_player"):
		can_interact = true
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	print("no")
	if area.get_parent().has_meta("the_player"):
		can_interact = false
	pass # Replace with function body.
