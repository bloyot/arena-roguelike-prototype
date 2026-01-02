@abstract
class_name Enemy extends CharacterBody2D

signal damage_taken(enemy_id, damage)
signal enemy_killed(enemy_id)

# TODO make this dynamically configured, probably loadable from a top level combat
# manager autoload or something
@export var player: Player
# all enemies should deal damage to the player when coming into contact, this returns the amount of damage to deal
@export var contact_damage: int
@export var contact_tick_rate_s: float
@export var move_speed: float
@export var aggro_range: float
# TODO pull this from the ability, or maybe conditional on magnitude of damage taken
@export var hit_stun_time: float 
@export var hit_flash_time: float 

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var damage_text_scene = preload("res://scenes/enemy/damage_text.tscn")
var damage_tick_timer: Timer
var hit_stun_timer: Timer
var hit_flash_timer: Timer

var enemy_id: int
var health: float = 10
var aggrod: bool = false
var is_hit_stun: bool = false

func _ready() -> void:
	sprite.frame = randi_range(0, sprite.sprite_frames.get_frame_count("idle") - 1)
	hitbox.area_entered.connect(on_area_entered)
	hitbox.area_exited.connect(on_area_exited)

	damage_tick_timer = Timer.new()
	add_child(damage_tick_timer)
	damage_tick_timer.timeout.connect(on_damage_tick)
	
	hit_stun_timer = Timer.new()
	hit_stun_timer.one_shot = true
	hit_stun_timer.timeout.connect(on_hit_stun_finished)
	add_child(hit_stun_timer)
	
	hit_flash_timer = Timer.new()
	hit_flash_timer.one_shot = true
	hit_flash_timer.timeout.connect(on_hit_flash_finished)
	add_child(hit_flash_timer)

func _physics_process(_delta: float) -> void:

	if !aggrod and player.global_position.distance_to(global_position) < aggro_range:
		aggrod = true
		sprite.play("run")

	if aggrod:
		navigation_agent.target_position = player.global_position
		var next_position: Vector2 = navigation_agent.get_next_path_position()
		velocity = (next_position - global_position).normalized() * move_speed
		set_facing()

	if !is_hit_stun:
		move_and_slide()	

func take_damage(damage: int) -> void:
	health -= damage
	damage_taken.emit(enemy_id, damage)
	hit_flash()
	spawn_damage_text(damage)
	hit_stun()
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

func set_facing() -> void:
	sprite.flip_h = true if player.position.x < position.x else false

func hit_flash() -> void:
	sprite.material.set("shader_parameter/active", true)
	hit_flash_timer.start(hit_flash_time)
	
func hit_stun() -> void:
	is_hit_stun = true
	hit_stun_timer.start(hit_stun_time)

func on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		damage_tick_timer.start(contact_tick_rate_s)

func on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		damage_tick_timer.stop()

func on_damage_tick() -> void:
	player.take_damage(contact_damage)
	
func on_hit_stun_finished() -> void: 
	is_hit_stun = false

func on_hit_flash_finished() -> void:
	sprite.material.set("shader_parameter/active", false)
	
