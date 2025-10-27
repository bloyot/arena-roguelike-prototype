extends BaseCharacterState
class_name MoveState

func get_animation_name() -> String:
	return "run"

func get_state() -> STATE:
	return STATE.MOVE

func update(_delta: float) -> STATE:
	if player.velocity.is_zero_approx():
		return STATE.IDLE
	return STATE.NONE
