extends CombatEntity

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 10
@export var state_machine: StateMachine


func _ready() -> void:
	current_health = max_health
	
func _physics_process(delta: float) -> void:
	state_machine._state_logic(delta)
