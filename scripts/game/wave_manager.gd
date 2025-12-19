class_name WaveManager extends Node

# TODO create a wave configuration resource to determine how many waves, what types, etc
# for now just set some exports 

@export var num_waves: int
@export var wave_size_min: int
@export var wave_size_max: float

@export var wave_enemy_scene: PackedScene
