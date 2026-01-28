@tool
extends RichTextEffect
class_name RichTextSup

var bbcode = "sup"

func _process_custom_fx(char_fx):
	var scale = .8
	char_fx.transform = char_fx.transform.scaled_local(Vector2(scale, scale))
	char_fx.offset = Vector2(0, -8)
	return true
