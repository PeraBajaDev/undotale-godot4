extends Node

@export var player_data: PlayerDataResource


func _ready() -> void:
	GlobalPlayerHealthComponent.max_health = player_data.max_health
	GlobalPlayerHealthComponent.set_initial_health(player_data.max_health)
