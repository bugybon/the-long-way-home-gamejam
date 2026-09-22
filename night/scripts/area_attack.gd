extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var damage:int = 0
@export var time_scale:float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("attack", -1, time_scale)


func _on_area_entered(area: Area2D) -> void:
	var target = area.get_parent()  # the Hurtbox's parent is the entity itself
	if target is CombatEntity:
		target.take_damage(damage)  # `self` = this Weapon, that's your "source"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
