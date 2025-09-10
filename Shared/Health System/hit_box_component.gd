class_name HitBoxComponent
extends Node

var damage: int:
	set(value):
		if value < 0:
			return
		damage = value
