class_name ActionButtons
extends HBoxContainer

signal action_button_pressed
signal action_finished
var buttons: Array[ActionButton] = []


func _ready() -> void:
	BattleManager.enemy_turn_ended.connect(focus_button)
	buttons.assign(get_children() as Array[ActionButton])
	buttons[0].grab_focus.call_deferred()
	for button in buttons:
		button.pressed.connect(action_button_pressed.emit)
		button.action_finished.connect(action_finished.emit)


func release_focus_buttons() -> void:
	for button in buttons:
		button.release_focus()


func focus_button() -> void:
	buttons[0].grab_focus.call_deferred()
