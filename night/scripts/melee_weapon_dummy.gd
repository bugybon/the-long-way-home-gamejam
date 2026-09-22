extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var melee_damage:int
var area_effect
var area_instance
signal attack_finished

func _ready() -> void:
	area_effect = preload("res://night/objects/area_attack.tscn")

func melee_attack_animation() -> void:
	animation_player.play("melee_attack")
	
func ranged_attack_animation() -> void:
	animation_player.play("ranged_attack")
	area_instance = area_effect.instantiate()
	area_instance.position = get_global_mouse_position()
	get_tree().current_scene.add_child(area_instance)

func _on_area_entered(area: Area2D) -> void:
	var target = area.get_parent()  # the Hurtbox's parent is the entity itself
	if target is CombatEntity:
		target.take_damage(melee_damage)  # `self` = this Weapon, that's your "source"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "melee_attack" or anim_name == "ranged_attack":
		attack_finished.emit()
