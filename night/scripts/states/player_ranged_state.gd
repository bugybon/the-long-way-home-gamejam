extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity = Vector2.ZERO
	player.weapon.ranged_attack_animation()
	attack_finished = false
	#player.animation_player.play("melee")

func physics_update(_delta: float) -> void:
	player.current_state.text = RANGED
	input_direction = player._get_direction()
	player.move_and_slide()
	if attack_finished == true:
		if input_direction != Vector2.ZERO:
			finished.emit(MOVING)
		else:
			finished.emit(IDLE)
