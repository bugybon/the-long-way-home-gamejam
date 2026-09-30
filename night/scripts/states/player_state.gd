class_name PlayerState extends State

const IDLE = "Idle"
const MOVING = "Moving"
const MELEE = "Melee"
const RANGED = "Ranged"

var player: CharacterBody2D
var input_direction:Vector2
var attack_finished:bool = false

func _ready() -> void:
	await owner.ready
	player = owner as CharacterBody2D
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	player.weapon.attack_finished.connect(_on_weapon_animation_finished)

func _on_weapon_animation_finished() -> void:
	attack_finished = true
