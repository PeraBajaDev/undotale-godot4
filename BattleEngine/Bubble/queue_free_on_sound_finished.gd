extends AudioStreamPlayer


func _ready() -> void:
	finished.connect(func() -> void: queue_free())
