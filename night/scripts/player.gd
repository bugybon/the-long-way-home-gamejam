extends CombatEntity

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapons: Node = $Weapons
@onready var player: CombatEntity = $"."
@onready var weapon: Area2D = $Weapons/MeleeWeaponDummy
@onready var attacks: Node = $Attacks
@onready var area_2d_vision: Area2D = $Area2DVision
var attack_directions: Dictionary[String,Node] = {}
@export var speed = 100

var direction = "front"
var input_direction: Vector2

func _ready() -> void:
	current_health = max_health
	for attack in attacks.get_children():
		attack_directions[attack.name] = attack

func transform_direction(input_direction) -> void:
	if input_direction == Vector2.ZERO:
		return
	 
	var angle = rad_to_deg(input_direction.angle_to(Vector2(1.0,1.0).normalized())) # quad1 diagonal
	if angle < -91.0: # angle_to makes front left to appear as left with 90 when front right is front
		direction = "left"
	elif angle <= 0.0:
		direction = "front"
	elif angle < 90.0:
		direction = "right"
	else:
		direction = "back"

func _get_direction():
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()

func apply_movement():
	velocity = input_direction * speed
	#transform_direction(input_direction)
	#print(input_direction, state + "_" + direction)
	#animated_sprite_2d.play(state + "_" + direction)
	#weapons.rotation = weapons.global_position.angle_to_point(attack_directions[direction].global_position)
	#area_2d_vision.rotation = area_2d_vision.global_position.angle_to_point(attack_directions[direction].global_position)
	weapons.look_at(get_global_mouse_position())
	area_2d_vision.look_at(get_global_mouse_position())

func _on_area_2d_vision_area_entered(area: Area2D) -> void:
	var target = area.get_parent()  # the Hurtbox's parent is the entity itself
	if target is CombatEntity:
		target.visible = true


func _on_area_2d_vision_area_exited(area: Area2D) -> void:
	var target = area.get_parent()  # the Hurtbox's parent is the entity itself
	if target is CombatEntity:
		target.visible = false
