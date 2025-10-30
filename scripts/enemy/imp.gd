class_name Imp extends Enemy

@export var contact_damage: int
@export var contact_tick_rate_s: int
@export var move_speed: int

func get_contact_damage() -> int:
	return contact_damage

func get_contact_tick_rate_s() -> float:
	return contact_tick_rate_s

func get_move_speed() -> float:
	return move_speed
