extends Node2D

# amount of frames before the end of an animation that we will store an input
var frame_buffer_frames: float = 60
# store the most recent input if we're mid animation
var frame_buffer: Array[Dictionary] = []

# Set the frame buffer based on the input every frame
func _physics_process(_delta: float) -> void:
	frame_buffer.push_back(input())
	if (frame_buffer.size() > frame_buffer_frames):
		frame_buffer.pop_front()

# read the input from the player
func input() -> Dictionary:
	return {
		"move_left": Input.is_action_pressed("move_left"),
		"move_right": Input.is_action_pressed("move_right"),
		"move_up": Input.is_action_pressed("move_up"),
		"move_down": Input.is_action_pressed("move_down"),
		"ability_1": Input.is_action_just_pressed("ability_1"),
		"ability_2": Input.is_action_just_pressed("ability_2"),
		"ability_3": Input.is_action_just_pressed("ability_3"),
		"ability_4": Input.is_action_just_pressed("ability_4"),
		"quit": Input.is_action_just_pressed("quit")
	}

# get the input map at the specified frame
func get_input(frames_back: int = 1) -> Dictionary:
	return frame_buffer[-1 * frames_back]

# return true if the input exists in the last x buffered frames
func has_buffered_input(input_name: String, frames_back: int = 1) -> bool:
	for frame: Dictionary in frame_buffer.slice(-1 * frames_back):
		if (frame.has(input_name) and frame[input_name]):
			return true
	return false
