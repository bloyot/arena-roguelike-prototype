class_name SlashAbility
extends Ability

@onready var animated_sprite: AnimatedSprite2D = $SlashFx
@onready var hitbox: Area2D = %Hitbox

var ability_id: int

# TODO make this configurable
var damage: int = 4

func _ready() -> void:
	super()
	toggle_fx(false)
	animated_sprite.animation_finished.connect(on_animation_finished)
	hitbox.area_entered.connect(on_area_entered)

func get_ability_id() -> int:
	return ability_id

func can_activate_ability() -> bool:
	return true

func activate_ability() -> void:
	toggle_fx(true)
	animated_sprite.play("slash")

func cancel_ability() -> void:
	pass

func get_ability_name() -> String:
	return "Slash"

func get_cooldown_s() -> float:
	return 0.0

func get_cost() -> int:
	return 0

func end_ability() -> void:
	super()
	toggle_fx(false)

func toggle_fx(enabled: bool) -> void:
	animated_sprite.visible = enabled
	hitbox.monitoring = enabled
	hitbox.monitorable = enabled

func on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Enemy:
		var enemy: Enemy = area.get_parent() as Enemy
		enemy.take_damage(damage)

func on_animation_finished() -> void:
	end_ability()
