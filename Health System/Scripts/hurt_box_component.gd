class_name HurtBoxComponent
extends Area2D

signal hitted

@export var health_component: HealthComponent

@export var invincibility_time: float

@onready var invencibility_timer: Timer = $InvencibilityTimer


func _ready() -> void:
	self.area_entered.connect(on_area_entered)
	if not health_component:
		push_warning("Falta asignar nodo healthComponent")
	if not invencibility_timer:
		push_warning("Falta asignar nodo invencibilityTimer")


func on_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		hurt(area as HitBoxComponent)


func hurt(hit_box: HitBoxComponent) -> void:
	print(invencibility_timer.is_stopped())
	if not invencibility_timer.is_stopped():
		return
	hitted.emit()
	health_component.harm(hit_box.damage)
	invencibility_timer.start(invincibility_time)
