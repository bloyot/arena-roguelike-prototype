class_name Player extends CharacterBody2D

enum FACING { LEFT, RIGHT }

# Signals
signal state_change(old_state: BaseCharacterState, new_state: BaseCharacterState)

static var DEFAULT_COLLISION_MASK: int = 0b0101
static var INTANGIBLE_COLLISION_MASK: int = 0b0001

# Children
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox
@onready var camera: Camera2D = $Camera
@onready var ability_system: AbilitySystem = %AbilitySystem
# Exports
@export var move_speed: float

# State variables
# track all states here for reference, map of STATE enum to BaseCharacterState object
var states: Dictionary = {
	BaseCharacterState.STATE.IDLE: IdleState.new(),
	BaseCharacterState.STATE.MOVE: MoveState.new()
}
# track our current state here
var curr_state: BaseCharacterState = null
# use this to avoid flipping our facing during the middle of an attack or other animation
var freeze_facing: bool = false

## player specific stuff goes here ##
var health = 50

########################################
########## Engine Overrides ############
########################################
func _ready() -> void:
	init_states()

func _physics_process(delta: float) -> void:
	var maybe_new_state: BaseCharacterState.STATE = curr_state.update(delta)
	if (maybe_new_state != BaseCharacterState.STATE.NONE):
		change_state(maybe_new_state)

	set_facing(determine_facing())
	handle_abilities()
	move(delta)

	if (InputManager.get_input()["quit"]):
		get_tree().quit()

func move(_delta: float) -> void:

	velocity = Vector2(0, 0)
	if InputManager.get_input()["move_left"]:
		velocity += Vector2(-move_speed, 0)
	if InputManager.get_input()["move_right"]:
		velocity += Vector2(move_speed, 0)
	if InputManager.get_input()["move_up"]:
		velocity += Vector2(0, -move_speed)
	if InputManager.get_input()["move_down"]:
		velocity += Vector2(0, move_speed)

	move_and_slide()

func handle_abilities() -> void:
	if InputManager.get_input()["ability_1"]:
		ability_system.use_ability(0, camera.get_global_mouse_position())
	if InputManager.get_input()["ability_2"]:
		ability_system.use_ability(1, camera.get_global_mouse_position())
	if InputManager.get_input()["ability_3"]:
		ability_system.use_ability(2, camera.get_global_mouse_position())
	if InputManager.get_input()["ability_4"]:
		ability_system.use_ability(3, camera.get_global_mouse_position())


func init_states() -> void:
	# setup the states
	var states_group: Array = states.values()
	for state: BaseCharacterState in states_group:
		state.setup(self)
		states[state.get_state()] = state
	curr_state = states[BaseCharacterState.STATE.IDLE]
	change_state(BaseCharacterState.STATE.IDLE)

func change_state(target_state: BaseCharacterState.STATE) -> void:
	assert(states.has(target_state), "STATE " + str(target_state) + " not present on character")
	var old_state: BaseCharacterState = curr_state
	var new_state: BaseCharacterState = states[target_state]

	old_state.on_exit()
	new_state.on_enter()

	curr_state = new_state
	state_change.emit(old_state, new_state)

func set_facing(facing: FACING) -> void:
	animated_sprite.flip_h = facing == FACING.LEFT

func get_facing() -> FACING:
	return FACING.RIGHT if scale.x > 0 else FACING.LEFT

func play_animation(animation_name: String) -> void:
	animated_sprite.play(animation_name)

func set_intangible(is_intangible: bool) -> void:
	collision_mask = INTANGIBLE_COLLISION_MASK if is_intangible else DEFAULT_COLLISION_MASK
	hitbox.collision_mask = INTANGIBLE_COLLISION_MASK if is_intangible else DEFAULT_COLLISION_MASK

func determine_facing() -> Player.FACING:
	return Player.FACING.RIGHT if camera.get_global_mouse_position().x > position.x else Player.FACING.LEFT

func take_damage(damage: int) -> void:
	print("taking " + str(damage) + " damage")
	health -= damage
	if health <= 0:
		get_tree().quit()
