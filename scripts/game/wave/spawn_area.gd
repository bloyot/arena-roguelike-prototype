@tool
class_name SpawnArea extends Node2D

@onready var area: CollisionShape2D = %CollisionShape2D

@export var radius: float:
	set(value):
		radius = value
		area.shape.radius = value

# return a point within the area to us for spawning an enemy
func get_spawn_point() -> Vector2:
	return Vector2.ZERO
