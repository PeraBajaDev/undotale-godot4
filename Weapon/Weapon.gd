extends Node2D

@onready var animations: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animations.play("slice")


func _on_animation_finished(_anim_name: String) -> void:
	animations.stop()
	queue_free()


func random_rotation() -> void:
	rotation_degrees = randf_range(0, 360)
