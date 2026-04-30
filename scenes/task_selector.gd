extends Control

var config: ConfigFile = ConfigFile.new()
var tasks:String = "res://tasks.cfg"
const btn_path:String = "res://assets/Widgets/OpenSceneButton.tscn"
@export var container:Control

func _ready():
	print("TaskSelector: Начинаю загрузку кнопок из файла " + tasks)
	if config.load(tasks) == OK:
		for section in config.get_sections():
			var btn = preload(btn_path).instantiate()
			container.add_child(btn)
			btn.text = "Задание " + section
			btn.task_id = int(section) - 1
			print("TaskSelector: Загружена кнопка задания \"" + section + "\" ID Задания \"" + str(int(section)-1) + "\"")
		
		print("TaskSelector: Загрузка кнопок завершена")
			
	else:
		push_error("TaskSelector: Не удалось найти %d", tasks)
