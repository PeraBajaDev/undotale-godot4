extends ActionButton

#var page := 0
#var page_old := 0
#var page_max := 0
#var second_row := false

@export var player_data: PlayerDataResource


func do_action() -> void:
	var selected_option: String = await BattleManager.display_options(player_data.items)
	var index: int = player_data.items.find(selected_option)
	player_data.items.remove_at(index)
	action_finished.emit()
