extends HBoxContainer

@export var player_data: PlayerDataResource
@onready var lv: RichTextLabel = $LV
@onready var player_name: RichTextLabel = $Name


func _ready() -> void:
	lv.text = "%d" % player_data.lv
	player_name.text = player_data.human
