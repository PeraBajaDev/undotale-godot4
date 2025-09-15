extends Node

@warning_ignore("unused_signal")
signal player_turn_started
@warning_ignore("unused_signal")
signal player_turn_ended
@warning_ignore("unused_signal")
signal enemy_turn_started
@warning_ignore("unused_signal")
signal enemy_turn_ended


func display_options(options: Array[String]) -> String:
	var dialogue_options: String = ""
	for option in options:
		dialogue_options += "- %s \n" % option
	var balloon: BoxDialogue = DialogueManager.show_dialogue_balloon(
		DialogueManager.create_resource_from_text(dialogue_options)
	)
	await balloon.response_selected
	return balloon.last_selected_response.text
