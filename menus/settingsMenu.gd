extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Event.open_settings.connect(_on_open_settings)
	
func _on_open_settings() -> void:
	visible = true
	animation_player.play("credits")
	get_tree().paused = true


func _on_button_pressed() -> void:
	animation_player.play("back")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "back":
		visible = false
		get_tree().paused = false
