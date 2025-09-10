extends Sprite2D

var enabled := false


func _ready() -> void:
	self.scale = Vector2(0.5, 0.5)


func _process(_delta: float) -> void:
	self.scale += Vector2(0.1, 0.1)
	self.modulate.a -= 0.05

	if self.modulate.a <= 0:
		self.queue_free()
