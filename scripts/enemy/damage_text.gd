class_name DamageText extends RichTextLabel

enum TEXT_TYPE {
	MISS,
	DODGE,
	DAMAGE,
	CRIT_DAMAGE
}

@export var float_distance: float
@export var float_duration: float
@export var total_duration: float
@export var miss_color: Color
@export var damage_color: Color

func _initialize(text_type_: TEXT_TYPE, text_: String) -> void:
	match text_type_:
		TEXT_TYPE.MISS:
			text = "[color=#" +  miss_color.to_html(false) + "]" + text_
		TEXT_TYPE.DAMAGE:
			text = "[color=#" +  damage_color.to_html(false) + "]" + text_

	var tween = get_tree().create_tween()
	tween.finished.connect(on_text_float_finished)
	tween.tween_property(self, "position", Vector2(position.x, position.y - float_distance), float_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func on_text_float_finished() -> void:
	await get_tree().create_timer(total_duration - float_duration).timeout
	queue_free()
