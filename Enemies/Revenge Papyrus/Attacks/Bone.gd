class_name Bone
extends CharacterBody2D

@export var damage := 50

var from := ""
var motion := Vector2(0, 0)

var save_size := 11
var save_position: float = 0

@onready var visual: NinePatchRect = $Bone
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var bone: NinePatchRect = $Bone


func _process(delta: float) -> void:
	match from:
		"top":
			pass
		"bot":
			visual.position.y = save_position + (save_size - visual.size.y)
		"none":
			visual.position.y = save_position + (save_size - visual.size.y) / 2.0
		_:
			switch_from()
	collision.position.y = visual.position.y + (visual.size.y / 2.0)

	move_and_collide(motion * delta)


func switch_from(new := "none") -> void:
	save_size = bone.size.y
	save_position = bone.position.y
	from = new


func _on_screen_exited() -> void:
	queue_free()
