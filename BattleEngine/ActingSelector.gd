class_name ActingSelector
extends Node2D

signal select
var input := Vector2.ZERO
var selection := 0

var enabled := false  # was "enable"

var positions := [
	Vector2(80, 285),
	Vector2(320, 285),
	Vector2(80, 315),
	Vector2(320, 315),
	Vector2(80, 350),
	Vector2(320, 350)
]
var soul: SoulController
var list: Array = []
@onready var squeak_sound: AudioStreamPlayer = %Squeak
@onready var select_sound: AudioStreamPlayer = %Select


func enable(soul: SoulController) -> void:
	self.soul = soul
	connect("select", Callable(self, "disable"))
	await get_tree().create_timer(0.1).timeout
	self.enabled = true


func _process(_delta: float) -> void:
	if enabled:
		input.x = (
			int(Input.is_action_just_pressed("ui_right"))
			- int(Input.is_action_just_pressed("ui_left"))
		)
		input.y = (
			(
				int(Input.is_action_just_pressed("ui_down"))
				- int(Input.is_action_just_pressed("ui_up"))
			)
			* 2
		)

		if input:
			squeak_sound.play()

		selection = int(selection + input.x + input.y) % list.size()

		soul.position = positions[selection]

		if Input.is_action_just_pressed("ui_accept"):
			self.enabled = false
			select_sound.play()
			select.emit()  #emit_signal("select")
		elif Input.is_action_just_pressed("ui_cancel"):
			squeak_sound.play()
			select.emit()  #emit_signal("select")


func get_option() -> String:
	var text := ""
	for index in range(list.size()):
		var option: String = list[index]
		if index % 2 == 1:
			for spaces in range(14 - len(list[index - 1])):
				text += " "
			text += "* " + option + "\n"
		else:
			text += "\t\t* " + option
	return text


func disable() -> void:
	disconnect("select", Callable(self, "disable"))


func get_selection() -> Monster:  # was "selection
	return list[selection]
