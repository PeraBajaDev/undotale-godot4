class_name Enemy
extends Node2D

signal action_ended
signal spared
var is_spared := false

@export var enemy_resource: EnemyResource
@onready var animations: AnimationPlayer = $Animations
@onready var sprite: Node2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent
var spare_counter: int:
	set(value):
		spare_counter = value if value >= 0 else 0


func _ready() -> void:
	animations.play("Idle")
	health_component.max_health = enemy_resource.max_health_points
	#var click: AudioStream = preload("res://Shared/Text/Clicks/Files/papyrus.wav")
	#click_sound.stream = click


func spare() -> void:
	if not enemy_resource.spareable:
		return
	print("Intentando Perdonando a:", enemy_resource.enemy_name)
	if spare_counter > enemy_resource.actions_necessary_to_spare:
		return
	is_spared = true
	spared.emit()


func shake(amount: float) -> void:
	var store_amount: float
	if store_amount == 0:
		store_amount = (amount / 100.0) + 0.01
	var offset_sign := (int(sprite.position.x >= 0) * 2) - 1
	sprite.position.x = -(amount * offset_sign)
	amount -= 1
	var test := amount / 100.0
	await get_tree().create_timer(store_amount - test).timeout
	if amount != 0:
		shake(amount)
	else:
		store_amount = 0


func acting() -> void:
	#Custom behaviour!
	pass


func bubble(line: String) -> void:
	var monster_line_resource := DialogueManager.create_resource_from_text(line)
	DialogueManager.show_dialogue_balloon(monster_line_resource)
