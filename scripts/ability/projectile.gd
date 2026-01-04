class_name Projectile extends Node2D

@onready var area: Area2D = %Hitbox

var velocity: float
var direction: Vector2

func _ready() -> void:
	area.area_entered.connect(on_area_entered)

# position is the initial position for the projectile
# direction should be a normalized vector pointing where the object should move
func construct(position_: Vector2, rotation: float, velocity_: float, direction_: Vector2) -> void:
	position = position_
	velocity = velocity_
	direction = direction_


func _physics_process(_delta: float) -> void:
	position += direction * velocity

func on_area_entered() -> void:
	print("projectile area entered")
	queue_free()
