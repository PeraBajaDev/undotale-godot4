class_name Blitter
extends RichTextLabel

signal next
@export var skippable := false

var line := ["Test! One two three, one two three", [-1], [0.035, 0.5], false]
var click := preload("res://Shared/Text/Clicks/Files/generic2.wav")

var ongoing := false

@onready var click_node: AudioStreamPlayer = $Click
@onready var timer: Timer = $Timer


func _ready() -> void:
	next.connect(_on_next)
	click_node.stream = click


func _process(_delta: float) -> void:
	if skippable:
		if Input.is_action_just_pressed("ui_accept") and !ongoing:
			emit_signal("next")
		elif Input.is_action_just_pressed("ui_cancel") and ongoing:
			freeze()


func freeze() -> void:
	timer.stop()
	ongoing = false
	visible_characters = len(line[0])


func feed(args: Array = [""]) -> void:
	ongoing = true

	timer.stop()

	for index in range(args.size()):
		if args[index] != null:
			line[index] = args[index]

	text = ""
	visible_characters = 0

	text = line[0]
	await get_tree().create_timer(0.1).timeout

	if line[3]:
		visible_characters = len(line[0])
		return

	next_character()


func next_character() -> void:
	if visible_characters < len(line[0]):
		visible_characters += 1
		click_node.play()
		var check := int(visible_characters in line[1])
		timer.start(line[2][check])
	else:
		ongoing = false


func _on_next() -> void:
	visible_characters = 0


func _on_text_timeout() -> void:
	next_character()
