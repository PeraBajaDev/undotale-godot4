@tool
class_name RichTextTrembles
extends RichTextEffect

var bbcode = "tremble"


func _process_custom_fx(char_fx):
	var freq = char_fx.env.get("freq", 0.0)
	var chance = char_fx.env.get("chance", 2)

	randomize()

	var random_bool = bool(randi() % 101 < chance)
	var random_vector = Vector2(randf_range(-freq, freq), randf_range(-freq, freq))

	if random_bool:
		char_fx.offset = random_vector
	return true
