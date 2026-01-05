class_name FireballAbility extends Ability

@export var fireball_projectile: PackedScene
@export var projectile_speed: float
@export var damage: int

var projectiles_node: Node2D

func _ready() -> void:
	# TODO need a better way to reference this object
	projectiles_node = get_tree().get_root().get_node("/root/Test/Objects/Projectiles") as Node2D

func can_activate_ability() -> bool:
	return true

func activate_ability() -> void:
	spawn_fireball()

func cancel_ability() -> void:
	pass

func get_ability_name() -> String:
	return "Fireball"

func spawn_fireball() -> void:
	var fireball: Projectile = fireball_projectile.instantiate() as Projectile
	var proj_direction = (get_global_mouse_position() - player.position).normalized()
	var proj_rotation = proj_direction.angle_to(Vector2(1, 0)) * -1
	fireball.construct(player.position, proj_rotation, projectile_speed, proj_direction, damage)
	projectiles_node.call_deferred('add_child', fireball)
