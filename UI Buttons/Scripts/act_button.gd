extends ActionButton

@export var enemies: Enemies


func do_action() -> void:
	var enemy := await enemies.get_selected_enemy()
	await enemy.act()
	action_finished.emit()
