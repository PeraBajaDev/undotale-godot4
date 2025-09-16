extends AudioStreamPlayer

@onready var hurt_box_component: HurtBoxComponent = get_parent()


func _ready() -> void:
	hurt_box_component.hitted.connect(play)
