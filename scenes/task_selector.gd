extends Control

var config: ConfigFile = ConfigFile.new()
var tasks = "res://tasks.cfg"
var btn_path = "res://assets/Widgets/OpenSceneButton.tscn"
@onready var container = $Panel/GridContainer

func _ready():
	if config.load(tasks) == OK:
		for section in config.get_sections():
			var btn = preload("res://assets/Widgets/OpenSceneButton.tscn").instantiate()
			container.add_child(btn)
			btn.text = "Задание " + section
			btn.task_id = int(section) - 1
			
	else:
		push_error("Unable to find %d", tasks)
