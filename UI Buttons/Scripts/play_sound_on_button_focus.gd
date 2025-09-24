extends AudioStreamPlayer


func _ready() -> void:
	var button: BaseButton = get_parent()
	button.focus_exited.connect(func() -> void: play())
