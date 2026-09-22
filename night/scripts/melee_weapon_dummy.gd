extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var melee_damage:int

signal attack_finished

func melee_attack_animation() -> void:
	animation_player.play("melee_attack")
	
func ranged_attack_animation() -> void:
	animation_player.play("ranged_attack")

func _on_area_entered(area: Area2D) -> void:
	var target = area.get_parent()  # the Hurtbox's parent is the entity itself
	if target is CombatEntity:
		target.take_damage(melee_damage)  # `self` = this Weapon, that's your "source"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	attack_finished.emit()
