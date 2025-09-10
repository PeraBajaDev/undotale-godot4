class_name HealthComponent
extends Node

@export var maxHealthLimit: int = 100
@export var maxHealth: int:
	set(value):
		maxHealth = value if value <= maxHealthLimit else maxHealthLimit
var health: int:
	set(value):
		health = value if value >= 0 else 0
signal damaged
signal maxHealthIncremented
signal died
signal dying


func _ready() -> void:
	health = maxHealth


func inscrease_max_health() -> void:
	maxHealth += 1
	maxHealthIncremented.emit()


func harm(value: int) -> void:
	health -= value
	damaged.emit()

	if health == 0:
		dying.emit()
		await get_tree().create_timer(0.5).timeout
		died.emit()
		get_parent().queue_free()
