extends BaseCharacterState
class_name IdleState

func get_animation_name() -> String:
	return "idle"

func get_state() -> STATE:
	return STATE.IDLE

func update(_delta: float) -> STATE:
	if !player.velocity.is_zero_approx():
		return STATE.MOVE
	return STATE.NONE
