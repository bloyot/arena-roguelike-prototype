class_name FireballProjectile extends Projectile

@onready var tip: Marker2D = %Tip

@export var aoe_indicator: PackedScene
@export var splash_damage: int
@export var splash_radius: float
@export var time_to_live: float


func on_body_entered(body_entered: Node2D) -> void:
	if body_entered is Enemy:
		body_entered.take_damage(damage)

	var aoe = aoe_indicator.instantiate()
	aoe.min_radius = splash_radius
	aoe.max_radius = splash_radius
	aoe.time_to_live = time_to_live
	aoe.filled = true
	aoe.position = tip.global_position

	# TODO write this function to check if it's an enemy that isn't the one that was initially
	# hit, and then deal the splash damage
	#aoe.on_body_entered_func = func(body: Node2D): print(body)

	Helpers.get_projectiles().call_deferred("add_child", aoe)

	call_deferred("queue_free")
