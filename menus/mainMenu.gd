extends Control

func _on_button_start_pressed() -> void:
	# get_tree().change_scene_to_file("res://stages/level_1.tscn")
	print("Pressed start")

func _on_button_settings_pressed() -> void:
	Event.open_settings.emit()

func _on_button_extra_credits_pressed() -> void:
	Event.open_credits.emit()
	
