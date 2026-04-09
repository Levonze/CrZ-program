extends Node2D

var enabled = false

const click_prt = "res://click_particle.tscn"

const scroll = "res://scroll_particle.tscn"

func toggle():
	enabled = not enabled
	LimboConsole.print_line("The current state: " + str(enabled))

func _ready():
	LimboConsole.register_command(toggle, "effects_toggle")

func _process(_delta):
	if enabled:
		if Input.is_action_just_pressed("click"):
			var mouse_pos = get_global_mouse_position()
			var prt = preload(click_prt).instantiate()
			prt.emitting = true
			get_tree().current_scene.add_child(prt)
			prt.position = mouse_pos
