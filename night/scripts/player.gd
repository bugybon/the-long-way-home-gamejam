extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapons: Node = $Weapons
@onready var attacks: Node = $Attacks
var attack_directions: Dictionary[String,Node] = {}
@export var speed = 100

var direction = "front"
var state = "idle"

func _ready() -> void:
	for attack in attacks.get_children():
		attack_directions[attack.name] = attack

func transform_direction(input_direction) -> void:
	if 	input_direction == Vector2(0,0):
		state = "idle"
		return
		
	state = "run"
	var angle = rad_to_deg(input_direction.angle_to(Vector2(1.0,1.0).normalized())) # quad1 diagonal
	if angle < -91.0: # angle_to makes front left to appear as left with 90 when front right is front
		direction = "left"
	elif angle <= 0.0:
		direction = "front"
	elif angle < 90.0:
		direction = "right"
	else:
		direction = "back"

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * speed
	transform_direction(input_direction)
	print(input_direction, state + "_" + direction)
	#animated_sprite_2d.play(state + "_" + direction)
	weapons.rotation = weapons.global_position.angle_to_point(attack_directions[direction].global_position)

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		weapons.get_children().map(func (el): el.attack_animation())
		


func _on_melee_weapon_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
