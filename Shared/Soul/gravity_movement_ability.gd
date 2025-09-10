class_name GravityMovementAbility
extends SoulAbility

var motion: Vector2
const JUMP_FORCE := 400


func update(owner: SoulController, _delta: float) -> void:
	var horizontal_input: float = Input.get_axis("ui_left", "ui_right")
	var is_jumping := Input.is_action_pressed("ui_up")

	motion.x = owner.speed * horizontal_input
	if not owner.is_on_floor():
		motion.y += owner.gravity * 2

	if owner.is_on_floor() and is_jumping:
		motion.y -= JUMP_FORCE
	if owner.is_on_ceiling():
		motion.y += owner.gravity * 2

	owner.set_velocity(motion)
	owner.set_up_direction(Vector2.UP)
	owner.move_and_slide()
