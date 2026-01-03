class_name WaveManager extends Node

@export var player: Player
# use this as the parent for all enemies in the scene
@export var enemies_node: Node2D

@export var spawn_radius: float = 30
@export var spawn_points: Array[SpawnArea] = []
@export var waves: Array[Wave] = []

var curr_wave: int = 0
var enemy_id_to_wave: Dictionary[int, int] = {}
var enemies_killed_by_wave: Dictionary[int, int] = {}
var next_enemy_id = 0

func _ready() -> void:
	EventManager.enemy_killed.connect(on_enemy_killed)
	EventManager.wave_complete.connect(on_wave_complete)
	spawn_wave(waves[0])

func spawn_enemy(scene: PackedScene) -> void:
	var enemy: Enemy = scene.instantiate()
	enemy.construct(player, generate_enemy_id())
	enemy.position = spawn_points[randi_range(0, spawn_points.size()-1)].get_spawn_point()
	enemies_node.call_deferred("add_child", enemy)

	enemy_id_to_wave[enemy.enemy_id] = curr_wave

func spawn_wave(wave: Wave) -> void:
	for enemy_scene: PackedScene in wave.enemies:
		for i in range(wave.enemies[enemy_scene]):
			spawn_enemy(enemy_scene)
	EventManager.wave_spawned.emit(curr_wave)

func generate_enemy_id() -> int:
	next_enemy_id += 1
	return next_enemy_id

func on_enemy_killed(enemy_id: int) -> void:
	var enemy_wave = enemy_id_to_wave[enemy_id]
	if Helpers.dict_get_or_null(enemies_killed_by_wave, enemy_wave) == null:
		enemies_killed_by_wave[enemy_wave] = 1
	else:
		enemies_killed_by_wave[enemy_wave] += 1

	# if we've killed all enemies in a wave, send the wave complete event
	if enemies_killed_by_wave[enemy_wave] == waves[enemy_wave].size():
		EventManager.wave_complete.emit(enemy_wave)

func on_wave_complete(_wave: int) -> void:
	curr_wave += 1

	if curr_wave == waves.size():
		EventManager.room_complete.emit()
	else:
		spawn_wave(waves[curr_wave])
