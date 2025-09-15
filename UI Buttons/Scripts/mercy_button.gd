extends ActionButton

@export var enemies: Enemies


func do_action() -> void:
	enemies.spare_all()
