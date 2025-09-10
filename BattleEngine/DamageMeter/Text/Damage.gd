extends Node2D

@onready var label: Label = $Label
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if int(label.text) > 0:
		label.set("theme_override_colors/font_color", Color(1, 0, 0, 1))
		audio.play()
	position.x = -(label.size.x / 2.0) + global_position.x
	animation.play("jump")


func _on_animation_finished(_anim_name: String) -> void:
	animation.stop()
	queue_free()
