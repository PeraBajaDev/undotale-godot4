extends Node2D

signal done
@export var monster_name = "Papyrus"
@export var spareable = true

var attack = 10
var deffense = 30

var check_line = "He is just a test monster after all"
var actings = ["Check", "Hey", "DidYouKnw", "ThatIdont", "knowhowto", "makeaMojito"]

var health_points = 100
var spared = false
var store_amount = 0

@onready var blitter = $Bubble/Blitter


func _ready():
	$Animations.play("Idle")
	connect("done", Callable(self, "test"))
	var click = preload("res://Shared/Text/Clicks/Files/papyrus.wav")
	$Bubble/Blitter/Click.stream = click


func spare():
	spared = true
	self.modulate.a = 0.3


func shake(amount):
	if store_amount == 0:
		store_amount = (amount / 100.0) + 0.01
	var offset_sign = (int($Sprite2D.position.x >= 0) * 2) - 1
	$Sprite2D.position.x = -(amount * offset_sign)
	amount -= 1
	var test = amount / 100.0
	await get_tree().create_timer(store_amount - test).timeout
	if amount != 0:
		shake(amount)
	else:
		store_amount = 0


func acting():
	#Custom behaviour!
	pass


func bubble(line):
	$Bubble.visible = true
	blitter.feed(line)
