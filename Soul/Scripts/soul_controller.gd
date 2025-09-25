class_name SoulController
extends CharacterBody2D

@export var current_function: String  # (String, "", "red", "blue")

var speed := 190
var motion := Vector2.ZERO
var gravity := 3

var jump := Vector2(40, 240)
var abilities: Array[SoulAbility]
var floor_rotation: float = 0
var can_move := true
@onready var ghost: PackedScene = preload("uid://dfw2ivtbr6sxu")


func _ready() -> void:
	add_ability(TopDownMovementAbility.new())
	changes_color(Color.RED)


func _physics_process(delta: float) -> void:
	if not can_move:
		return
	for ability in abilities:
		ability.update(self, delta)


func _unhandled_input(event: InputEvent) -> void:
	for ability in abilities:
		ability.input_handler(event)


func changes_color(color: Color) -> void:
	modulate = color


func add_ability(ability: SoulAbility) -> void:
	var ghost_inst := ghost.instantiate()
	self.add_child(ghost_inst)
	abilities.append(ability)


func remove_ability(ability_type: String) -> void:
	return abilities.filter(
		func(ability: Object) -> bool: return ability.get_class() != ability_type
	)
