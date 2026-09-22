extends StateMachine

var direction = "front"
var attack_finished:bool
@onready var current_state: Label = $"../CurrentState"

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
	current_state.text = states.find_key(state)
	parent.velocity = Vector2.ZERO
	if ![states.ranged,states.melee].has(state):
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
			parent.weapon.melee_attack_animation()
		states.ranged:
			parent.weapon.ranged_attack_animation()

func _exit_state(old_state:Variant,new_state:Variant) -> void:
	pass
	
func _on_weapon_animation_finished() -> void:
	attack_finished = true
