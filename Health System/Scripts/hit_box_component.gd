class_name HitBoxComponent
extends Area2D

@export var damage: int:
	set(value):
		if value < 0:
			return
		damage = value
