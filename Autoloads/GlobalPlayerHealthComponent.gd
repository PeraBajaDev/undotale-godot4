extends HealthComponent


func set_initial_health(value: int) -> void:
	_health = value if value >= 0 else 0
