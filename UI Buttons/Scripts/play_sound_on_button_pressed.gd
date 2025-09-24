extends AudioStreamPlayer


func _ready() -> void:
	var button: BaseButton = get_parent()
	button.pressed.connect(func() -> void: play())
