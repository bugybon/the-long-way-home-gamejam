extends StateMachine

var player:CharacterBody2D
var attack_finished:bool

func _ready() -> void:
	super._ready()
	await owner.ready
	player = owner as CharacterBody2D
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	player.weapon.attack_finished.connect(_on_weapon_animation_finished)

func _state_transition() -> void:
	if Input.is_action_just_pressed("attack_ranged"):
		state.finished.emit("Ranged")
		pass
	elif Input.is_action_just_pressed("attack_melee"):
		state.finished.emit("Melee")
		pass
	
	match state.name:
		"Melee","Ranged":
			if attack_finished == true:
				state.finished.emit("Idle")
		"Idle":
			if player.input_direction != Vector2.ZERO:
				state.finished.emit("Moving")
		"Moving":
			if player.input_direction == Vector2.ZERO:
				state.finished.emit("Idle")

func _on_weapon_animation_finished() -> void:
	attack_finished = true
