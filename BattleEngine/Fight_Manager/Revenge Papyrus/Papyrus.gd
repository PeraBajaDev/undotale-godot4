class_name Monster
extends Node2D

signal done
@export var monster_name := "Papyrus"
@export var spareable := true

var attack := 10
var defense := 30

var check_line := "He is just a test monster after all"
var actings := ["Check", "Hey", "DidYouKnw", "ThatIdont", "knowhowto", "makeaMojito"]

var health_points := 100
var spared := false
var store_amount := 0

@onready var blitter: Blitter = $Bubble/Blitter
@onready var animations: AnimationPlayer = $Animations
@onready var click_sound: AudioStreamPlayer = $Bubble/Blitter/Click
@onready var bubble_node: Node2D = $Bubble
@onready var sprite: Node2D = $Sprite2D


func _ready() -> void:
	animations.play("Idle")
	connect("done", Callable(self, "test"))
	var click: AudioStream = preload("res://Shared/Text/Clicks/Files/papyrus.wav")
	click_sound.stream = click


func spare() -> void:
	spared = true
	self.modulate.a = 0.3


func shake(amount: float) -> void:
	if store_amount == 0:
		store_amount = (amount / 100.0) + 0.01
	var offset_sign := (int(sprite.position.x >= 0) * 2) - 1
	sprite.position.x = -(amount * offset_sign)
	amount -= 1
	var test := amount / 100.0
	await get_tree().create_timer(store_amount - test).timeout
	if amount != 0:
		shake(amount)
	else:
		store_amount = 0


func acting() -> void:
	#Custom behaviour!
	pass


func bubble(line: String) -> void:
	bubble_node.visible = true
	blitter.feed([line])
