extends Node2D

signal select
var input
var selection = 0

var enabled = false

var positions = [50, 205, 362, 517]
var soul

@onready var children = self.get_children()


func enable(_soul):
	self.soul = _soul
	select.connect(disable)  # connect("select", Callable(self, "disable"))
	self.enabled = true


func _process(_delta):
	if enabled:
		input = (
			int(Input.is_action_just_pressed("ui_right"))
			- int(Input.is_action_just_pressed("ui_left"))
		)

		if input:
			%Squeak.play()

		children[selection].frame = 0
		selection = (selection + input) % 4
		children[selection].frame = 1

		soul.position = Vector2(positions[selection], 453)

		if Input.is_action_just_pressed("ui_accept"):
			get_parent().get_node("Select").play()
			select.emit()


func disable():
	self.enabled = false
	select.disconnect(disable)  # disconnect("select", Callable(self, "disable"))


func turn_off():
	for child in get_children():
		child.frame = 0


func get_selection():  # was "selection
	return children[selection].name
