@tool
extends RichTextEffect
class_name RichTextSub

var bbcode = "sub"

func _process_custom_fx(char_fx):
	var scale = .7
	char_fx.transform = char_fx.transform.scaled_local(Vector2(scale, scale))
	char_fx.offset = Vector2(2, 4)
	return true
