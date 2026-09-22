extends StateMachine

var direction = "front"
var attack_finished:bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_state("idle")
	add_state("moving")
	add_state("melee")
	add_state("ranged")
	call_deferred("set_state",states.idle)
	call_deferred("_connect_weapon_signal")

func _connect_weapon_signal() -> void:
	parent.weapon.attack_finished.connect(_on_weapon_animation_finished)

func _input(event:InputEvent) -> void:
	if [states.idle, states.moving].has(state):
		if Input.is_action_just_pressed("attack_melee"):
			state = states.melee
			attack_finished = false
			parent.weapons.get_children().map(func (el): el.melee_attack_animation())
		elif Input.is_action_just_pressed("attack_ranged"):
			state = states.ranged
			attack_finished = false
			parent.weapons.get_children().map(func (el): el.ranged_attack_animation())

func _state_logic(delta: float) -> void:
	#if state != states.melee:
	parent._get_direction()
	parent.apply_movement()
	parent.move_and_slide()

func _get_transition(delta: float) -> Variant:
	match state:
		states.idle:
			if parent.velocity != Vector2.ZERO:
				return states.moving 
		states.moving:
			if parent.velocity == Vector2.ZERO:
				return states.idle 
		states.melee, states.ranged:
			if attack_finished:
				return states.idle
			
	return null

func _enter_state(new_state:Variant, old_state:Variant) -> void:
	match new_state:
		states.melee:
			parent.velocity *= 0.2
			parent.weapon.melee_attack_animation()
		states.ranged:
			parent.velocity = Vector2.ZERO
			parent.weapon.ranged_attack_animation()

func _exit_state(old_state:Variant,new_state:Variant) -> void:
	pass
	
func _on_weapon_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		attack_finished = true
