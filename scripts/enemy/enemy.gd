@abstract
class_name Enemy extends Node2D

signal damage_taken(enemy_id, damage)
signal enemy_killed(enemy_id)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

var damage_text_scene = preload("res://scenes/enemy/damage_text.tscn")

var enemy_id: int
var health: float = 10

# all enemies should deal damage to the player when coming into contact, this returns the amount of damage to deal
@abstract
func get_contact_damage() -> int

func _ready() -> void:
	sprite.frame = randi_range(0, sprite.sprite_frames.get_frame_count("idle") - 1)
	hitbox.area_entered.connect(on_area_entered)

func take_damage(damage: int) -> void:
	health -= damage
	damage_taken.emit(enemy_id, damage)
	hit_flash()
	spawn_damage_text(damage)
	if health <= 0:
		die()

func die() -> void:
	enemy_killed.emit(enemy_id)
	queue_free()

func spawn_damage_text(damage: int) -> void:
	var damage_text: DamageText = damage_text_scene.instantiate() as DamageText
	add_child(damage_text)
	damage_text.position.y -= 10
	damage_text.scale = Vector2(.5, .5)
	damage_text._initialize(DamageText.TEXT_TYPE.DAMAGE, str(damage))

func hit_flash() -> void:
	sprite.material.set("shader_parameter/active", true)
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(func(): sprite.material.set("shader_parameter/active", false))
	timer.start(0.1)

func on_area_entered(area: Area2D) -> void:
	print(area)
