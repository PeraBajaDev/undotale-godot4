extends ProgressBar

@export var player_data: PlayerDataResource


func _ready() -> void:
	max_value = player_data.max_health
	value = max_value
	GlobalPlayerHealthComponent.damaged.connect(on_health_changed)
	GlobalPlayerHealthComponent.healed.connect(on_health_changed)


func on_health_changed(_amount: int) -> void:
	print(GlobalPlayerHealthComponent.health)
	value = GlobalPlayerHealthComponent.health
