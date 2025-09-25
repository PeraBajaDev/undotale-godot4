extends Sprite2D

const SOUL_BREAK_RECT_Y_POSITION: int = 74
const SOUL_BREAK_RECT_WIDTH: int = 20


func _ready() -> void:
	await get_tree().create_timer(1)
	region_rect = Rect2(
		region_rect.position.x,
		SOUL_BREAK_RECT_Y_POSITION,
		SOUL_BREAK_RECT_WIDTH,
		region_rect.size.y
	)
