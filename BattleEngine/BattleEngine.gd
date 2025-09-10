class_name BattleEngine
extends Node2D

signal shake_camera

var selection: Monster
var function: String
var store_amnt := 0
var random := [-1, 1]
@onready var Attacker: PackedScene = preload("res://BattleEngine/DamageMeter/DamageMeter.tscn")
@onready var Slice: PackedScene = preload("res://BattleEngine/Weapon/Weapon.tscn")
@onready var Damage: PackedScene = preload("res://BattleEngine/DamageMeter/Text/Damage.tscn")

@onready var box: Box = $Box
@onready var global_attacks := $Attacks
@onready var attacks := $Box/Attacks
@onready var blitter: Blitter = $Box/Blitter
@onready var enemies: RevengePapyrus = $Enemies
@onready var soul: SoulController = $Soul
@onready var camera: Camera2D = $Camera3D
@onready var buttons: Buttons = $Buttons
@onready var acting: ActingSelector = $ActingSelector
@onready var items: ItemSelector = $ItemSelector
@onready var music: AudioStreamPlayer = $Music


func _ready() -> void:
	shake_camera.connect(_on_shake_camera)  # connect("shake_camera", Callable(self, "shake_camera"))
	music.play(10)
	var hud: RichTextLabel = $HUD/Name
	hud.text = Data.human
	players_turn()


func _process(_delta: float) -> void:
	pass


func players_turn(reset_line := true) -> void:
	if reset_line:
		blitter.feed(["* You feel puzzled.", [22], null, false])
	buttons.enable(soul)
	await buttons.select
	#blitter.feed(["", null, null, true])

	function = buttons.get_selection()
	match function:
		"Fight", "Act", "Mercy":
			target()
		"Item":
			if Data.items.is_empty():
				players_turn(false)
				return
			items.enable(soul, blitter)
			await items.select
			if items.enabled:
				items.enabled = false
				players_turn()
				return


func target() -> void:
	enemies.enable(soul)
	blitter.feed([acting.get_option(), null, null, true])
	await acting.select
	selection = acting.get_selection()

	if enemies.enabled:
		enemies.enabled = false
		players_turn()
		return

	match function:
		"Fight":
			buttons.turn_off()
			soul.position = Vector2(-10, -10)

			var attacker: DamageMeter = Attacker.instantiate()
			attacker.position = box.position + (box.size / 2)
			attacker.slaughter.connect(slay)
			attacker.enemys_turn.connect(enemys_turn)

			blitter.feed()

			add_child(attacker)
			print(attacker.rotation)
		"Act":
			acting.list = selection.actings
			blitter.feed([acting.get_option(), null, null, true])
			acting.enable(soul)
			await acting.select

			if acting.enabled:
				acting.enabled = false
				target()
				return

			buttons.turn_off()
			# var get_act_string = selection.acting(acting.selection)

		"Mercy":
			buttons.turn_off()
			if selection.spareable:
				selection.spare()
			blitter.feed(["", null, null, true])
			enemys_turn()


func slay() -> void:
	var slice: Node2D = Slice.instantiate()
	slice.position = selection.position
	add_child(slice)
	await get_tree().create_timer(1).timeout

	var damage: Node2D = Damage.instantiate()
	damage.position = selection.position
	selection.shake(15)
	var label: Label = damage.get_node("Label")
	label.text = "%d " % selection.defense

	add_child(damage)

	print(damage.rotation)


func enemys_turn() -> void:
	enemies.cutscene(box)
	await enemies.cutscene_end

	enemies.attack()
	await enemies.cutscene_end

	soul.abilities.clear()
	players_turn()


func _on_shake_camera(amount := 5) -> void:
	if store_amnt == 0:
		store_amnt = (amount / 100.0) + 0.01
	var offset_sign := Vector2(
		(int(camera.offset.x >= 0) * 2) - 1, (int(camera.offset.y >= 0) * 2) - 1
	)
	camera.offset = Vector2(
		-(amount * offset_sign.x), random[randi() % random.size()] * (amount * offset_sign.y)
	)
	amount -= 1
	var test: float = amount / 100.0
	await get_tree().create_timer(store_amnt - test).timeout
	if amount != 0:
		_on_shake_camera(amount)  # ether: idk if this is calling the signal or the function itself
	else:
		store_amnt = 0
