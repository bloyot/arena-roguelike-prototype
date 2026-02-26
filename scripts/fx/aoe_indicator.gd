@tool
class_name AoEIndicator extends Node2D

@onready var area: Area2D = %Area2D
@onready var collision: CollisionShape2D = %CollisionShape2D

@export var border_color: Color
@export var fill_color: Color
@export var min_radius: float
@export var max_radius: float
@export var time_to_live: float
@export var growth_time: float
@export var filled: bool = false
@export var width: float = 1.0

var on_body_entered_func = func(_body: Node2D): print("override me")
var curr_radius: float
var ttl_timer: Timer

func _ready() -> void:
	curr_radius = min_radius
	var circleShape: CircleShape2D = collision.shape as CircleShape2D
	circleShape.radius = curr_radius
	area.body_entered.connect(on_body_entered_func)

	# create the timer to remove the aoe after the ttl
	ttl_timer = Timer.new()
	ttl_timer.one_shot = true
	add_child(ttl_timer)
	ttl_timer.timeout.connect(on_ttl_timeout)

	# if the min size is different from the max size, spawn a tween to
	# grow the circle
	if max_radius > min_radius:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "curr_radius", max_radius, growth_time)
		tween.parallel().tween_property(circleShape, "radius", max_radius, growth_time)
		tween.tween_callback(func(): ttl_timer.start(time_to_live))
	else:
		ttl_timer.start(time_to_live)

func _draw():
	draw_circle(Vector2(0, 0), curr_radius, border_color, false, width)
	if filled:
		draw_circle(Vector2(0,0), curr_radius, fill_color, true)

func _process(_delta: float) -> void:
	if max_radius > min_radius:
		queue_redraw()

func on_ttl_timeout() -> void:
	if Engine.is_editor_hint():
		print("ttl timeout")
	else:
		# doing this in the editor crashes the engine
		# since you can't free the root node of a running scene without causing issues
		queue_free()
