class_name EnemyResource
extends Resource

@export var enemy_name := "Papyrus"
@export var spareable := true
@export var max_health_points: int = 100
@export var attack: int = 10
@export var defense: int = 30
@export var actions_necessary_to_spare: int = 5
@export var actings: Dictionary[String, String] = {"Check": "Is The great papyrus"}
