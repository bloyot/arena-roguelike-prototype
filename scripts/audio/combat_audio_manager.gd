class_name CombatAudioManager extends Node

enum FX_NAME {
	FIREBALL,
	FIREBALL_IMPACT,
	FOOTSTEP,
	DASH
}

@export var fireball: AudioStreamMP3
@export var fireball_impact: AudioStreamMP3
@export var footstep: AudioStreamMP3
@export var dash: AudioStreamWAV

@onready var music_audio_stream_player: AudioStreamPlayer2D = %MusicAudioStreamPlayer2D
@onready var fx_audio_stream_player: AudioStreamPlayer2D = %FxAudioStreamPlayer2D

var fx_map: Dictionary[FX_NAME, AudioStream] = {}

func _ready() -> void:
	fx_map[FX_NAME.FIREBALL] = fireball
	fx_map[FX_NAME.FIREBALL_IMPACT] = fireball_impact
	fx_map[FX_NAME.FOOTSTEP] = footstep
	fx_map[FX_NAME.DASH] = dash
	music_audio_stream_player.play()

func play_fx(sound: FX_NAME) -> void:
	fx_audio_stream_player.stream = fx_map[sound]
	fx_audio_stream_player.play()

func stop_fx() -> void:
	fx_audio_stream_player.stop()
