extends Node

signal damage_taken(enemy_id, damage)
signal enemy_killed(enemy_id)

signal wave_spawned(wave: int)
signal wave_complete(wave: int)
signal room_complete
