class_name DashAbility extends Ability

@export var cooldown_s: float
@export var cost: int

var ability_id: int

func get_ability_id() -> int:
	return ability_id

func can_activate_ability() -> bool:
	return true

func activate_ability() -> void:
	player.change_state(BaseCharacterState.STATE.DASH)

func cancel_ability() -> void:
	pass

func get_ability_name() -> String:
	return "Dash"

func get_cooldown_s() -> float:
	return cooldown_s

func get_cost() -> int:
	return cost
