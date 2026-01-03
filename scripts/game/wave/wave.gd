class_name Wave extends Resource

@export var enemies: Dictionary[PackedScene, int] = {}

func size() -> int:
	var result: int = 0
	for scene: PackedScene in enemies:
		result += enemies[scene]

	return result
