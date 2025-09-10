class_name FightManager
extends Node2D

signal select
signal cutscene_end
var vertical_input: float
var selection := 0

var enabled := false  # was "enable"

var possible_positions := [285, 315, 350]
var position_array := []
var soul: SoulController

var monsters: Array[Monster] = []

#var cutscene = [] # ether: wasn't commented before
@onready var squeak_sound: AudioStreamPlayer = %Squeak
@onready var select_sound: AudioStreamPlayer = %Select


func cutscene(_arg: Box) -> void:  # ether: to be overloaded?
	pass


func _ready() -> void:
	cutscene_end.connect(get_selection)  # connect("cutscene_end", Callable(self, "selection"))


func _process(_delta: float) -> void:
	if enabled:
		vertical_input = (
			int(Input.is_action_just_pressed("ui_down"))
			- int(Input.is_action_just_pressed("ui_up"))
		)

		if vertical_input:
			squeak_sound.play()

		selection = int(selection + vertical_input) % monsters.size()
		soul.position = Vector2(80, position_array[selection])

		if Input.is_action_just_pressed("ui_accept"):
			self.enabled = false
			select_sound.play()
			select.emit()
		elif Input.is_action_just_pressed("ui_cancel"):
			squeak_sound.play()
			select.emit()


func enable(_soul: SoulController) -> void:
	monsters.clear()
	for child in get_children() as Array[Monster]:
		if !child.spared:
			monsters.append(child.monster_name)

	position_array = possible_positions.slice(0, monsters.size())
	self.soul = _soul
	select.connect(disable)
	await get_tree().create_timer(0.1).timeout
	enabled = true


func disable() -> void:
	select.disconnect(disable)


func get_formated_name() -> String:
	var formated_name := ""
	for child in monsters:
		var monster_name: String = "\t\t* " + child.monster_name + "\n"
		if child.spareable:
			monster_name = "[color=yellow]" + monster_name + "[/color]"
		formated_name += monster_name
	return formated_name


func get_selection() -> Monster:
	return monsters[selection]


func _on_select() -> void:
	pass
