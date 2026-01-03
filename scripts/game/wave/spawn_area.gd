@tool
class_name SpawnArea extends Node2D

@onready var area: CollisionShape2D = %CollisionShape2D

@export var radius: float:
	set(value):
		radius = value
		if area != null:
			area.shape.radius = value

# return a point within the area to us for spawning an enemy
func get_spawn_point() -> Vector2:
	return global_position + Vector2(0, randf_range(0, radius)).rotated(randf_range(0, 2 * PI))
