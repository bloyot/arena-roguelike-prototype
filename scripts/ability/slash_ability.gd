class_name SlashAbility
extends Ability

@onready var animated_sprite: AnimatedSprite2D = $SlashFx
@onready var hitbox: Area2D = %Hitbox

func _ready() -> void:
	toggle_fx(false)
	animated_sprite.animation_finished.connect(on_animation_finished)

func can_activate_ability() -> bool:
	return true

func activate_ability() -> void:
	toggle_fx(true)
	animated_sprite.play("slash")

func cancel_ability() -> void:
	pass

func get_ability_name() -> String:
	return "Slash"

func end_ability() -> void:
	super()
	toggle_fx(false)

func toggle_fx(enabled: bool) -> void:
	animated_sprite.visible = enabled
	hitbox.monitoring = enabled
	hitbox.monitorable = enabled

func on_animation_finished() -> void:
	end_ability()
