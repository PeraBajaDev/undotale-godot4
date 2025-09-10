class_name Buttons
extends Node2D

signal select
var horizontal_input: float
var selection := 0

var enabled := false

var positions := [50, 205, 362, 517]
var soul: SoulController

@onready var children: Array[AnimatedSprite2D] = []
@onready var squeak_sound: AudioStreamPlayer = %Squeak
@onready var select_sound: AudioStreamPlayer = %Select


func _ready() -> void:
	children.assign(self.get_children())


func enable(_soul: SoulController) -> void:
	self.soul = _soul
	select.connect(disable)  # connect("select", Callable(self, "disable"))
	self.enabled = true


func _process(_delta: float) -> void:
	if enabled:
		horizontal_input = (
			int(Input.is_action_just_pressed("ui_right"))
			- int(Input.is_action_just_pressed("ui_left"))
		)

		if horizontal_input:
			squeak_sound.play()

		children[selection].frame = 0
		selection = int(selection + horizontal_input) % 4
		children[selection].frame = 1

		soul.position = Vector2(positions[selection], 453)

		if Input.is_action_just_pressed("ui_accept"):
			select_sound.play()
			select.emit()


func disable() -> void:
	self.enabled = false
	select.disconnect(disable)  # disconnect("select", Callable(self, "disable"))


func turn_off() -> void:
	for child in children:
		child.frame = 0


func get_selection() -> String:  # was "selection
	return children[selection].name
