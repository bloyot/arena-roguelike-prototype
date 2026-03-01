extends BaseCharacterState
class_name MoveState

var audio_manager: CombatAudioManager

func get_animation_name() -> String:
	return "run"

func setup(_player: Player) -> void:
	super(_player)
	audio_manager = Helpers.get_audio_manager() as CombatAudioManager

func get_state() -> STATE:
	return STATE.MOVE

func on_enter() -> void:
	super()
	audio_manager.play_fx(CombatAudioManager.FX_NAME.FOOTSTEP)

func on_exit() -> void:
	super()
	audio_manager.stop_fx()

func update(_delta: float) -> STATE:
	if player.velocity.is_zero_approx():
		return STATE.IDLE
	return STATE.NONE
