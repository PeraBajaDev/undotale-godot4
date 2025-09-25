extends CanvasModulate


func _ready() -> void:
	GlobalPlayerHealthComponent.died.connect(func() -> void: color = Color.BLACK)
