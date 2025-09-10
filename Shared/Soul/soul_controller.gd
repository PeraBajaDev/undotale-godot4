class_name SoulController
extends CharacterBody2D

@export var current_function: String  # (String, "", "red", "blue")

var speed := 190
var motion := Vector2.ZERO
var gravity := 3

var jump := Vector2(40, 240)
var abilities: Array[SoulAbility]
var floor_rotation: float = 0

@onready var ghost: PackedScene = preload("res://Shared/Soul/Ghost.tscn")


func _ready() -> void:
	add_ability(GravityMovementAbility.new())
	change_soul_color(Color.BLUE)


func _physics_process(delta: float) -> void:
	for ability in abilities:
		ability.update(self, delta)


func _unhandled_input(event: InputEvent) -> void:
	for ability in abilities:
		ability.input_handler(event)


func change_soul_color(color: Color) -> void:
	modulate = color


func add_ability(ability: SoulAbility) -> void:
	var ghost_inst := ghost.instantiate()
	self.add_child(ghost_inst)
	abilities.append(ability)


func remove_ability(ability_type: String) -> void:
	return abilities.filter(
		func(ability: Object) -> bool: return ability.get_class() != ability_type
	)
