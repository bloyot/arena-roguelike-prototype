@abstract
class_name Enemy extends Node2D

signal damage_taken(enemy_id, damage)
signal enemy_killed(enemy_id)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var enemy_id: int
var health: float = 10

func take_damage(damage: int) -> void:
	health -= damage
	damage_taken.emit(enemy_id, damage)
	hit_flash()
	# TODO damage text
	if health <= 0:
		die()

func die() -> void:
	enemy_killed.emit(enemy_id)
	queue_free()

func hit_flash() -> void:
	sprite.material.set("shader_parameter/Active", true)
	var timer: Timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.3
	timer.timeout.connect(func(): sprite.material.set("shader_parameter/Active", false))
