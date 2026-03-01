class_name DashState extends BaseCharacterState

var audio_manager: CombatAudioManager

var dash_tween: Tween
var dash_complete: bool = false

func setup(_player: Player) -> void:
	super(_player)
	audio_manager = Helpers.get_audio_manager() as CombatAudioManager

func get_animation_name() -> String:
	return "run"

func get_state() -> STATE:
	return STATE.DASH

func on_enter() -> void:
	super()
	player.input_locked = true
	player.set_intangible(true)

	# get the direction that we're going to dash
	var target_vector: Vector2 = (player.camera.get_global_mouse_position() - player.position).normalized()
	player.velocity = target_vector * player.dash_speed

	dash_tween = player.create_tween()
	dash_tween.set_ease(Tween.EASE_OUT)
	dash_tween.tween_property(player, "velocity", Vector2.ZERO, player.dash_duration)
	dash_tween.finished.connect(func(): dash_complete = true)

	audio_manager.play_fx(CombatAudioManager.FX_NAME.DASH)


func on_exit() -> void:
	player.input_locked = false
	dash_complete = false
	player.set_intangible(false)

func update(_delta: float) -> STATE:

	if dash_complete:
		return STATE.IDLE
	return STATE.NONE
