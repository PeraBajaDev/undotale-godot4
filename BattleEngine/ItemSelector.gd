class_name ItemSelector
extends Node2D

#var page := 0
#var page_old := 0
#var page_max := 0
#var second_row := false

var list: Array[Array] = []

@onready var squeak_sound: AudioStreamPlayer = %Squeak
@onready var select_sound: AudioStreamPlayer = %Select


func set_items(items: Array[String]) -> void:
	var options_text: String = ""
	for item in items:
		options_text += "- %s \n" % item
		print(options_text)
	var balloon: BoxDialogue = DialogueManager.show_dialogue_balloon(
		DialogueManager.create_resource_from_text(options_text)
	)
