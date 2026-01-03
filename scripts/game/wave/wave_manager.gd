class_name WaveManager extends Node

@export var spawn_radius: float = 30
@export var spawn_points: Array[SpawnArea] = []
@export var waves: Array[Wave] = []
# use this as the parent for all enemies in the scene
@export var enemies_node: Node2D

var curr_wave: int = 0

func _ready() -> void:
	spawn_wave(waves[0])

func spawn_enemy(scene: PackedScene) -> void:
	var enemy: Enemy = scene.instantiate()
	enemy.position = spawn_points[randi_range(0, spawn_points.size()-1)].get_spawn_point()
	enemies_node.add_child(enemy)

func spawn_wave(wave: Wave) -> void:
	for enemy_scene: PackedScene in wave.enemies:
		for i in range(wave.enemies[enemy_scene]):
			spawn_enemy(enemy_scene)
