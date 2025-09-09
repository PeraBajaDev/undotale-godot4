class_name List
extends Node2D

signal selected
signal exit

var list = []

var selection = 0
var input = Vector2.ZERO

var enabled = false
var list_increase = Vector2.ZERO


func enable():
	selected.connect(on_selected)
	enabled = true


func _process(_delta):
	if enable:
		input.x = (
			(
				int(Input.is_action_just_pressed("ui_right"))
				- int(Input.is_action_just_pressed("ui_left"))
			)
			* list_increase.x
		)
		input.y = (
			(
				int(Input.is_action_just_pressed("ui_down"))
				- int(Input.is_action_just_pressed("ui_up"))
			)
			* list_increase.y
		)

		selection = int(selection + input.x + input.y) % list.size()

		if Input.is_action_just_pressed("ui_accept"):
			selected.emit()
			disable()


func disable():
	selected.disconnect(on_selected)
	enabled = false


func on_selected():
	return list[selection]
