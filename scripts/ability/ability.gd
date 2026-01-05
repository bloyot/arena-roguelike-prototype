@abstract
class_name Ability
extends Node2D

signal ability_activated(ability_name: String)
signal ability_ended(ability_name: String)

@export var player: Player

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
	if can_activate_ability():
		commit_ability()
		ability_activated.emit(get_ability_name())
		activate_ability()
