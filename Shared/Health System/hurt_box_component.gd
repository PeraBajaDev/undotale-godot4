class_name HurtBoxComponent
extends Area2D

@export var healthComponent: HealthComponent

@export var invincibilityTime: float
signal hitted
@onready var invencibilityTimer: Timer = $InvencibilityTimer


func _ready() -> void:
	self.body_entered.connect(on_hurt)
	healthComponent.died.connect(queue_free)
	if not healthComponent:
		push_warning("Falta asignar nodo healthComponent")
	if not invencibilityTimer:
		push_warning("Falta asignar nodo invencibilityTimer")


func on_hurt(hit_box: HitBoxComponent) -> void:
	if not invencibilityTimer.is_stopped():
		return

	hitted.emit()
	healthComponent.harm(hit_box.damage)
	invencibilityTimer.start(invincibilityTime)
