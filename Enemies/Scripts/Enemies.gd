class_name Enemies
extends Node

signal enemies_actions_ended

@onready var enemies: Array[Enemy] = []


func _ready() -> void:
	enemies.assign(get_children())
	for enemy in enemies:
		await enemy.action_ended
	enemies_actions_ended.emit()


func spare_all() -> void:
	for enemy in enemies:
		enemy.spare()


func get_node_names() -> Array[String]:
	var enemies_names: Array[String] = []
	enemies_names.assign(enemies.map(func(enemy: Enemy) -> String: return enemy.name))
	return enemies_names


func get_selected_enemy() -> Enemy:
	var selected_target := await BattleManager.display_options(get_node_names())
	for enemy in enemies:
		if enemy.name == selected_target:
			return enemy
	return null
