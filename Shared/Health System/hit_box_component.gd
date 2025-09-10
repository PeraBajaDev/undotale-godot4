class_name HitBoxComponent
extends Area2D

var damage: int:
	set(value):
		if value < 0:
			return
		damage = value
