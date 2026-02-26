class_name BaseCharacterState

enum STATE {
	NONE,
	IDLE,
	MOVE,
	DASH
}

var player: Player
var animation_length: float = 0

## Movement
static var facing: Player.FACING = Player.FACING.RIGHT

func setup(_player: Player) -> void:
	self.player = _player
	self.animation_length = player.animated_sprite.sprite_frames.get_frame_count(get_animation_name())

### Interface functions
func get_state() -> STATE:
	push_error("Uninteded interface function call get state name")
	return STATE.NONE

func get_animation_name() -> String:
	push_error("Uninteded interface function call get animation name")
	return ""

### Base class functions
func update(_delta: float) -> STATE:
	return STATE.NONE

func on_enter() -> void:
	player.play_animation(get_animation_name())

func on_exit() -> void:
	pass

func on_hit() -> void:
	pass
