class_name ActionButton
extends TextureButton
@warning_ignore("unused_signal")
signal action_finished
@export var action_name: String


func _ready() -> void:
	pressed.connect(do_action)


func do_action() -> void:
	pass
