class_name HealthComponent
extends Node

signal damaged
signal max_health_incremented
signal died
signal dying

@export var max_health_limit: int = 100
@export var max_health: int:
	set(value):
		max_health = value if value <= max_health_limit else max_health_limit
var health: int:
	set(value):
		health = value if value >= 0 else 0


func _ready() -> void:
	health = max_health


func inscrease_max_health() -> void:
	max_health += 1
	max_health_incremented.emit()


func harm(value: int) -> void:
	health -= value
	damaged.emit()

	if health == 0:
		dying.emit()
		await get_tree().create_timer(0.5).timeout
		died.emit()
		get_parent().queue_free()
