extends Node

@onready var health_component: HealthComponent = get_parent()
@onready var Slice: PackedScene = preload("res://BattleEngine/Weapon/Weapon.tscn")
@onready var Damage: PackedScene = preload("res://BattleEngine/DamageMeter/Text/Damage.tscn")


func _ready() -> void:
	health_component.damaged.connect(slay)


func slay(damage_amount: int) -> void:
	var enemy: Enemy = health_component.get_parent()
	var slice: Node2D = Slice.instantiate()
	slice.position = enemy.position
	add_child(slice)
	await get_tree().create_timer(1).timeout

	var damage: Node2D = Damage.instantiate()
	damage.position = enemy.position
	enemy.shake(15)
	var label: Label = damage.get_node("Label")
	label.text = "%d" % damage_amount
	add_child(damage)

	print(damage.rotation)
