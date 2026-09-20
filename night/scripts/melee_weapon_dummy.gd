extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var damage:int

func attack_animation() -> void:
	animation_player.play("attack")
	



func _on_area_entered(area: Area2D) -> void:
	var target = area.get_parent()  # the Hurtbox's parent is the entity itself
	if target is CombatEntity:
		target.take_damage(damage)  # `self` = this Weapon, that's your "source"
