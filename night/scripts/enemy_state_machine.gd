extends StateMachine

@onready var current_state: Label = $"../CurrentState"
@onready var player: CombatEntity = $"../../../Player"
@onready var me: CombatEntity = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_state("idle")
	add_state("pursuing")
	call_deferred("set_state",states.idle)

func _get_transition(delta: float) -> Variant:
	match state:
		states.idle:
			if me.visible:
				return states.pursuing
		states.pursuing:
			if !me.visible:
				return states.idle
	return null
	
func _state_logic(delta: float) -> void:
	match state:
		states.idle:
			return
		states.pursuing:
			if !player: return
			var dir = (player.position - me.position).normalized()
			me.velocity = dir * me.speed
			me.move_and_slide()
			return
	pass
	
