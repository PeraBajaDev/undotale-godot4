class_name BattleEngine
extends Node2D

signal shake_camera
@export var dialogue_resource: DialogueResource
@export var enemies_options: DialogueResource

var action: String
@onready var Attacker: PackedScene = preload("res://BattleEngine/DamageMeter/DamageMeter.tscn")

@onready var enemies: Enemies = $Enemies
@onready var soul: SoulController = $Soul
@onready var camera: Camera2D = $Camera3D
@onready var music: AudioStreamPlayer = $Music

@onready var action_buttons: ActionButtons = %ActionButtons


func _ready() -> void:
	shake_camera.connect(_on_shake_camera)
	music.play(10)
	BattleManager.player_turn_ended.connect(enemies_turn)
	BattleManager.enemy_turn_ended.connect(players_turn)
	players_turn()


func players_turn() -> void:
	soul.can_move = false
	soul.hide()
	BattleManager.player_turn_started.emit()
	var balloon := DialogueManager.show_dialogue_balloon(dialogue_resource)
	await action_buttons.action_finished

	action_buttons.release_focus_buttons()
	BattleManager.player_turn_ended.emit()
	balloon.queue_free()


func enemies_turn() -> void:
	soul.can_move = true
	soul.show()
	BattleManager.enemy_turn_started.emit()
	enemies.start_attack()
	await enemies.enemies_actions_ended
	BattleManager.enemy_turn_ended.emit()


func _on_shake_camera(amount := 5) -> void:
	var store_amount: float
	if store_amount == 0:
		store_amount = (amount / 100.0) + 0.01
	var offset_sign := Vector2(
		(int(camera.offset.x >= 0) * 2) - 1, (int(camera.offset.y >= 0) * 2) - 1
	)
	camera.offset = Vector2(
		-(amount * offset_sign.x), [1, -1].pick_random() * (amount * offset_sign.y)
	)
	amount -= 1
	var test: float = amount / 100.0
	await get_tree().create_timer(store_amount - test).timeout
	if amount != 0:
		_on_shake_camera(amount)  # ether: idk if this is calling the signal or the action itself
	else:
		store_amount = 0
