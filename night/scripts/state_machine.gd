extends Node
class_name StateMachine

var state:Variant = null : set = set_state
var previous_state:Variant = null
var states:Dictionary[String,int] = {}

@onready var parent = get_parent()

func _physics_process(delta: float) -> void:
	if state == null:
		return
	
	_state_logic(delta)
	var transition = _get_transition(delta)
	if transition != null:
		set_state(transition)

func _state_logic(delta: float) -> void:
	pass

func _get_transition(delta: float) -> Variant:
	return null

func _enter_state(new_state:Variant, old_state:Variant) -> void:
	pass

func _exit_state(old_state:Variant,new_state:Variant) -> void:
	pass

func set_state(new_state:Variant) -> void:
	previous_state = state
	state = new_state
	
	if previous_state != null:
		_exit_state(previous_state, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state)

func add_state(state_name:String) -> void:
	states[state_name] = states.size()
