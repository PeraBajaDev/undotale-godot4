class_name DamageMeter
extends Node2D

signal slaughter
signal enemys_turn

var stopped: bool = false
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var bar: AnimatedSprite2D = $Bar


func _ready() -> void:
	animation.play_backwards("Out")


func _process(delta: float) -> void:
	if not stopped:
		bar.position.x += 350 * delta
		if Input.is_action_just_pressed("ui_accept") or bar.position.x > 280:
			hit()


func hit() -> void:
	stopped = true
	slaughter.emit()
	bar.play()
	await get_tree().create_timer(2).timeout
	disappear()


func disappear() -> void:
	enemys_turn.emit()
	bar.queue_free()
	animation.play("Out")


func _on_animation_finished(_anim_name: String) -> void:
	if bar == null:
		queue_free()
