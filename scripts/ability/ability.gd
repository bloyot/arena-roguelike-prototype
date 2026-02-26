@abstract
class_name Ability
extends Node2D

signal ability_activated(ability_name: String)
signal ability_ended(ability_name: String)

@export var player: Player

var cooldown_timer: Timer = Timer.new()

@abstract
func get_ability_id() -> int

# check activation conditions and costs
@abstract
func can_activate_ability() -> bool

# do the actual ability logic, typically don't call this directly, favor try_activate_ability
@abstract
func activate_ability() -> void

# cancel the in progress ability
@abstract
func cancel_ability() -> void

@abstract
func get_ability_name() -> String

func get_tags() -> Array[String]:
	return []

@abstract
func get_cooldown_s() -> float

@abstract
func get_cost() -> int

func _ready() -> void:
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)

# pay costs like mana or other resources
# default no op, override if needed
func commit_ability() -> void:
	pass

# things that should happen once the ability is complete
# default no op, override if needed
func end_ability() -> void:
	ability_ended.emit()

# check can_activate_ability and activate it if valid
func try_activate_ability() -> void:
	if cooldown_timer.is_stopped() and can_activate_ability():
		commit_ability()
		ability_activated.emit(get_ability_name())
		activate_ability()

		# if this ability has a cooldown, start the timer
		if get_cooldown_s() != 0:
			cooldown_timer.start(get_cooldown_s())
