class_name RevengePapyrus
extends FightManager

# MAKE CUSTOM CUTSCENES AS YOU WISH

var box: Box
var cutscene_counter := 0
@onready var bone_tscn: PackedScene = preload(
	"res://BattleEngine/Fight_Manager/Revenge Papyrus/Attacks/Bone.tscn"
)
@onready var papyrus: Monster = $Papyrus


func cutscene(varbox: Box) -> void:  #YOU CAN CHOOSE WHAT PARAMETERS TO PASS IN
	box = varbox
	soul.position = varbox.position + (varbox.size / 2)
	soul.change_movement("still")
	match cutscene_counter:
		0:
			varbox.resize(Vector2(300, 140), 1, 1, 1.5)
			papyrus.bubble("NYEH HEH HEH!! FUCK OFF, HUMANO")
			await papyrus.blitter.next
			papyrus.bubble_node.visible = false

	cutscene_end.emit()


func attack() -> void:
	soul.change_movement("red")
	soul.change_movement("blue")
	for i in range(3):
		var bone: Bone = bone_tscn.instantiate()
		bone.motion = Vector2(100, 0)
		bone.switch_from("bot")
		box.attacks.add_child(bone)
		bone.global_position = box.global_position + Vector2(-30, box.size.y - 16)
		bone.visual.size.y = 30
		await get_tree().create_timer(1).timeout
	box_adopts(soul, get_parent())
	box.move(Vector2.ZERO)
	for i in range(3):
		var bone: Bone = bone_tscn.instantiate()
		bone.motion = Vector2(100, 0)
		bone.switch_from("bot")
		box.attacks.add_child(bone)
		bone.global_position = box.global_position + Vector2(-30, box.size.y - 16)
		bone.visual.size.y = 30
		await get_tree().create_timer(1).timeout

	box.resize(Vector2(575, 140), 1, 1, 0.8, Vector2(32, 250))

	for i in range(5):
		var bone: Bone = bone_tscn.instantiate()
		bone.motion = Vector2(100, 0)
		bone.switch_from("bot")
		box.attacks.add_child(bone)
		bone.global_position = box.global_position + Vector2(-30, box.size.y - 16)
		bone.visual.size.y = 30
		await get_tree().create_timer(1).timeout
		if box.has_node("Soul"):
			box_adopts(soul, get_parent(), true)
		box.resize(Vector2(box.size.x - 100, 140), 1, 1, 1)

	await get_tree().create_timer(4).timeout

	box_adopts(soul, get_parent(), true)
	for child in box.attacks.get_children():
		child.queue_free()
	box.resize(Vector2(575, 140), 1, 1, 0.8, Vector2(32, 250))
	cutscene_end.emit()


func box_adopts(node: Node2D, from: Node2D = self, reverse := false) -> void:
	if reverse:
		var node_pos := node.global_position
		box.remove_child(node)
		from.add_child(node)
		node.global_position = node_pos
	else:
		var node_pos := node.global_position
		from.remove_child(node)
		box.add_child(node)
		node.global_position = node_pos
