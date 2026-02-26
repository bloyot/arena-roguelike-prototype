class_name AbilitySystem extends Node2D

@onready var pivot: Node2D = %Pivot

var abilities: Array[Ability] = []

func _ready() -> void:
	var ability_id: int = 0
	for ability_node: Node2D in get_tree().get_nodes_in_group("ability"):
		if ability_node is Ability:
			ability_node.ability_id = ability_id
			ability_id += 1
			abilities.append(ability_node as Ability)

func use_ability(ability_index, target_pos: Vector2) -> void:
	if ability_index >= abilities.size():
		push_error("no ability configured for index " + str(ability_index))

	pivot.global_rotation = global_position.angle_to_point(target_pos)
	abilities[ability_index].try_activate_ability()
