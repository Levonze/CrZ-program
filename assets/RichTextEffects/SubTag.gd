@tool
extends RichTextEffect
class_name RichTextSub

var bbcode = "sub"

func _process_custom_fx(char_fx):
	var x = char_fx.env.get("x", 2)
	var y = char_fx.env.get("y", 4)
	var scale = .7
	char_fx.transform = char_fx.transform.scaled_local(Vector2(scale, scale))
	char_fx.offset = Vector2(x,y)
	return true
