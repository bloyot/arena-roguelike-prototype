class_name AbilitySystem extends Node2D

@onready var pivot: Node2D = %Pivot
@onready var slash_ability: Ability = %SlashAbility

var player: Player

func use_ability(ability_name: String, target_pos: Vector2) -> void:
	# TODO use ability name
	pivot.global_rotation = global_position.angle_to_point(target_pos)
	slash_ability.try_activate_ability()
