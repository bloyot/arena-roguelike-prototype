class_name FireballAbility extends Ability

@export var fireball_projectile: PackedScene

func can_activate_ability() -> bool:
	return true

func activate_ability() -> void:
	# todo spawn projectile in the direction we're aiming
	print("activate fireball")
	var fireball: Projectile = fireball_projectile.instantiate() as Projectile
	fireball.construct(position, 1.0, Vector2(0, 1))
	add_child(fireball)

func cancel_ability() -> void:
	pass

func get_ability_name() -> String:
	return "Fireball"
