extends HBoxContainer

@export var player_data: PlayerDataResource
@onready var health_label: RichTextLabel = $CurrentHP
@onready var max_health_label: RichTextLabel = $MaxHP


func _ready() -> void:
	max_health_label.text = "%d" % player_data.max_health
	health_label.text = "%d" % player_data.max_health
	GlobalPlayerHealthComponent.damaged.connect(_on_health_changed)
	GlobalPlayerHealthComponent.healed.connect(_on_health_changed)


func _on_health_changed(_amount: int) -> void:
	health_label.text = "%d" % GlobalPlayerHealthComponent.health
