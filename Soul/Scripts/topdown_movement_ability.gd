class_name TopDownMovementAbility
extends SoulAbility


func update(owner: SoulController, _delta: float) -> void:
	var input: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var motion := owner.speed * input
	owner.set_velocity(motion)
	owner.move_and_slide()


func input_handler(_event: InputEvent) -> void:
	pass
