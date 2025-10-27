class_name SlashAbility
extends Ability

@onready var animated_sprite: AnimatedSprite2D = $SlashFx

func can_activate_ability() -> bool:
	return true

func activate_ability() -> void:
	animated_sprite.play("slash")

func cancel_ability() -> void:
	pass

func get_ability_name() -> String:
	return "Slash"
