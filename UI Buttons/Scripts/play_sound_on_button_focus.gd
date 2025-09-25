extends AudioStreamPlayer


func _ready() -> void:
	var button: BaseButton = get_parent()
	button.focus_exited.connect(_on_focus_exited)
	GlobalPlayerHealthComponent.died.connect(button.focus_exited.disconnect.bind(_on_focus_exited))


func _on_focus_exited() -> void:
	play()
