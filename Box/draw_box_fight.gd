class_name BoxFight
extends Node2D

enum ExpandDirections { UP, LEFT, RIGHT, DOWN }
const BOX_OFFSET: Vector2 = Vector2.DOWN * 50

@export var border_width: int = 8
@onready var up_wall: CollisionShape2D = $Walls/UpCollisionShape2D
@onready var down_wall: CollisionShape2D = $Walls/DownCollisionShape2D
@onready var left_wall: CollisionShape2D = $Walls/LeftCollisionShape2D
@onready var right_wall: CollisionShape2D = $Walls/RightCollisionShape2D


func _ready() -> void:
	var initial_position := global_position
	var tween := create_tween()
	tween.tween_method(expand.bind(ExpandDirections.LEFT), 0, 1, 2)
	tween.tween_property(self, "global_position", initial_position + Vector2.LEFT * 50, 6)
	tween.tween_method(expand.bind(ExpandDirections.UP), 0, 2, 4)
	tween.tween_method(expand.bind(ExpandDirections.RIGHT), 0, -.6, 4)


func _process(delta: float) -> void:
	rotate(delta)
	queue_redraw()


func expand(size_amount: float, direction: ExpandDirections) -> void:
	match direction:
		ExpandDirections.UP:
			up_wall.position.y -= size_amount
		ExpandDirections.DOWN:
			down_wall.position.y += size_amount
		ExpandDirections.RIGHT:
			right_wall.position.x += size_amount
		ExpandDirections.LEFT:
			left_wall.position.x -= size_amount


func _draw() -> void:
	var top_left := Vector2(left_wall.position.x, up_wall.position.y)
	var bottom_right := Vector2(right_wall.position.x, down_wall.position.y)
	var size := bottom_right - top_left
	draw_rect(Rect2(top_left + BOX_OFFSET, size), Color.WHITE, false, border_width)
