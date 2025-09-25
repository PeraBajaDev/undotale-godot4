class_name HealthComponent
extends Node

signal damaged(amount: int)
signal max_health_incremented
signal healed(amount: int)
signal died

@export var max_health: int:
	set(value):
		max_health = value if value > 0 else 1
var health: int:
	get:
		return _health
var _health: int


func _ready() -> void:
	_health = max_health


func inscrease_max_health(amount: int) -> void:
	max_health += amount
	max_health_incremented.emit()


func harm(amount: int) -> void:
	_health -= amount
	if _health < 0:
		_health = 0
	damaged.emit(amount)

	if _health == 0:
		died.emit()


func heal(amount: int) -> void:
	_health += amount
	if _health > max_health:
		_health = max_health
	healed.emit(amount)
