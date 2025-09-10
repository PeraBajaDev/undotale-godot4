class_name Box
extends Control

@export var border := 5

@onready var attacks := $Attacks
@onready var shapes: Node2D = $Collisions


func _ready() -> void:
	#resize(Vector2(100,100), 0)
	pass


func _process(_delta: float) -> void:
	update_size()


func update_size() -> void:
	#shapes.get_child(0).position.x = -100 + border
	#shapes.get_child(1).position.y = -100 + border
	#shapes.get_child(2).position.y = self.size.y + 100 - border
	#shapes.get_child(3).position.x = self.size.x + 100 - border
	pass


func resize(
	dimension: Vector2, top := 1, bot := 1, time := 1.5, newpos: Vector2 = Vector2.INF
) -> void:
	var resize_tween := get_tree().create_tween()
	resize_tween.tween_property(self, "size", dimension, time).set_ease(Tween.EASE_OUT).set_trans(
		Tween.TRANS_QUINT
	)
	match top:
		0:
			pass
		1:
			(
				resize_tween
				. tween_property(
					self, "position:y", self.position.y + ((size.y - dimension.y) / 2.0), time
				)
				. set_ease(Tween.EASE_OUT)
				. set_trans(Tween.TRANS_QUINT)
			)
		2:
			(
				resize_tween
				. tween_property(self, "position:y", self.position.y + (size.y - dimension.y), time)
				. set_ease(Tween.EASE_OUT)
				. set_trans(Tween.TRANS_QUINT)
			)
	match bot:
		0:
			pass
		1:
			(
				resize_tween
				. tween_property(
					self, "position:x", self.position.x + ((size.x - dimension.x) / 2.0), time
				)
				. set_ease(Tween.EASE_OUT)
				. set_trans(Tween.TRANS_QUINT)
			)
		2:
			(
				resize_tween
				. tween_property(self, "position:x", self.position.x + (size.x - dimension.x), time)
				. set_ease(Tween.EASE_OUT)
				. set_trans(Tween.TRANS_QUINT)
			)

	var pos_tween := get_tree().create_tween()
	if newpos != Vector2.INF:
		(
			resize_tween
			. tween_property(self, "position", newpos, time + 0.1)
			. set_ease(Tween.EASE_OUT)
			. set_trans(Tween.TRANS_QUINT)
		)


func move(newpos: Vector2, time := 1.0) -> void:
	var pos_tween: Tween = get_tree().create_tween()
	(
		pos_tween
		. tween_property(self, "position", newpos, time + 0.1)
		. set_ease(Tween.EASE_OUT)
		. set_trans(Tween.TRANS_QUINT)
	)


func add_attack(node: Node2D) -> void:
	attacks.add_child(node)
	print(node.global_position)
