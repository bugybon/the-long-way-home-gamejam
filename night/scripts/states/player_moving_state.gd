extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.apply_movement()
	#player.animation_player.play("idle")

func physics_update(_delta: float) -> void:
	player.current_state.text = MOVING
	input_direction = player._get_direction()
	player.apply_movement()
	player.move_and_slide()

	#if Input.is_action_just_pressed("attack_melee"):
		#finished.emit(MELEE)
	#elif Input.is_action_just_pressed("attack_ranged"):
		#finished.emit(RANGED)
	#elif input_direction == Vector2.ZERO:
		#finished.emit(IDLE)
