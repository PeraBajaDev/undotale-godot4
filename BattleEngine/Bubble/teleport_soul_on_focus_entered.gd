extends Button

@export var soul_icon: Texture2D
@export var empty_icon: AtlasTexture


func _ready() -> void:
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)


func _on_focus_entered() -> void:
	icon = soul_icon


func _on_focus_exited() -> void:
	icon = empty_icon
