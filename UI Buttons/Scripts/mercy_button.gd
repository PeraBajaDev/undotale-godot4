extends ActionButton

@export var enemies: Enemies


func do_action() -> void:
	var selected_option := await BattleManager.display_options(["Mercy", "Flee"])
	match selected_option:
		"Flee":
			pass
		"Mercy":
			enemies.spare_all()
	action_finished.emit()
