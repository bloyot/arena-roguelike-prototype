class_name Projectile extends Node2D

@onready var area: Area2D = %Hitbox

var velocity: float
var direction: Vector2
var damage: int

func _ready() -> void:
	area.body_entered.connect(on_body_entered)

# position is the initial position for the projectile
# direction should be a normalized vector pointing where the object should move
func construct(
		position_: Vector2,
		rotation_: float,
		velocity_: float,
		direction_: Vector2,
		damage_: int) -> void:
	position = position_
	velocity = velocity_
	direction = direction_
	rotation = rotation_
	damage = damage_

func _physics_process(_delta: float) -> void:
	position += direction * velocity

func on_body_entered(body_entered: Node2D) -> void:
	if body_entered is Enemy:
		body_entered.take_damage(damage)

	queue_free()
