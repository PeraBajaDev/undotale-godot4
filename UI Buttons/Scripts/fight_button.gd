extends ActionButton

@export var enemies: Enemies


func do_action() -> void:
	var enemy := await enemies.get_selected_enemy()
	if not enemy:
		push_error("No se ha seleccionado ningún enemigo")
	enemy.health_component.harm(10)
	action_finished.emit()
