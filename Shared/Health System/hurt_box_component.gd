class_name HurtBoxComponent
extends Area2D

signal hitted

@export var health_component: HealthComponent

@export var invincibility_time: float

@onready var invencibility_timer: Timer = $InvencibilityTimer


func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	health_component.died.connect(queue_free)
	if not health_component:
		push_warning("Falta asignar nodo healthComponent")
	if not invencibility_timer:
		push_warning("Falta asignar nodo invencibilityTimer")


func on_body_entered(body: Node2D) -> void:
	if body is HitBoxComponent:
		hurt(body as HitBoxComponent)


func hurt(hit_box: HitBoxComponent) -> void:
	if not invencibility_timer.is_stopped():
		return

	hitted.emit()
	health_component.harm(hit_box.damage)
	invencibility_timer.start(invincibility_time)
