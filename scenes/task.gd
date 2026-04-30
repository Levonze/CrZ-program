extends Node
class_name TaskManager

@export var cur_task:int = 1
@export var Tasks:TaskContainer

@export var prev_btn:Button
@export var check_btn:Button
@export var next_btn:Button

var ESC := char(27)
var RED := ESC + "[31m"
var GREEN := ESC + "[32m"
var YELLOW := ESC + "[33m"
var CYAN := ESC + "[36m"
var BOLD := ESC + "[1m"
var RESET := ESC + "[0m"

func _ready() -> void:
	prev_btn.pressed.connect(handle_prev)
	check_btn.pressed.connect(handle_check)
	next_btn.pressed.connect(handle_next)
	
	if GameInstance.task_id == 9:
		next_btn.disabled = true
	
	if GameInstance.task_id == 0:
		prev_btn.disabled = true

func load_task(id:int):
	print("TaskHandler: Загружаю задание " + str(id))
	var data = Tasks.Tasks[int(id)]
	cur_task = id
	
	%TaskElement.text = data.task_data
	%GalvanicElement.text = data.task_scheme
	
	clear_fields()
	%TaskNum.text = "Задание: " + str(id+1)
	
	print("=========="+
	"\nЗагружено задание.\n"+"ID: "+str(id)+
	"\nNumber: "+str(id+1)+
	"\nTaskElement: "+data.task_data+
	"\nScheme: "+data.task_scheme+
	"\n\nAnodeIs: "+data.anod_element+
	"\nKatodeIs: "+data.katod_element+
	"\nAnode Formula: "+data.anod_formula+
	"\nKatode Formula: "+data.katod_formula+
	"\nAnode Index: "+str(data.anod_int)+
	"\nKatode Index: "+str(data.katod_int)+
	"\nIon Formula: "+data.ion_formula+
	"\nMolekular Formula: "+data.molekula_formula+
	"\n==========")
	
func clear_fields():
	%AnodeIs.text = ""
	%KatodeIs.text = ""
	%AnodeFormula.text = ""
	%AnodeNum.value = 0.0
	%KatodeFormula.text = ""
	%KatodNum.value = 0.0
	%IonFormula.text = ""
	%MolekularFormula.text = ""

func handle_check():
	if check():
		%ResultLabel.text = "Все верно"
		%ResultLabel.label_settings.font_color = Color(0,.5,0)
	else:
		%ResultLabel.text = "Задание решено не верно.\nПроверьте написание формул, они должны быть без пробелов.\nСпец. Символы можно скопировать из зеленого поля."
		%ResultLabel.label_settings.font_color = Color(1,0,0)

func check() -> bool:
	var data = Tasks.Tasks[cur_task]
	print(CYAN + "TaskHandler: Начинаю проверку задания " + BOLD + YELLOW + str(cur_task) + RESET)
	var all_correct = true

	if %AnodeIs.text.to_lower() != data.anod_element.to_lower():
		all_correct = false
		print(RED + "⚠ AnodeIs: неверное значение. Ожидается: " + BOLD + str(data.anod_element) + RESET)

	if %KatodeIs.text.to_lower() != data.katod_element.to_lower():
		all_correct = false
		print(RED + "⚠ KatodeIs: неверное значение. Ожидается: " + BOLD + str(data.katod_element) + RESET)

	if %AnodeFormula.text.to_lower() != data.anod_formula.to_lower():
		all_correct = false
		print(RED + "⚠ AnodeFormula: неверное значение. Ожидается: " + BOLD + str(data.anod_formula) + RESET)

	if int(%AnodeNum.value) != data.anod_int:
		all_correct = false
		print(RED + "⚠ AnodeNum: неверное значение. Ожидается: " + BOLD + str(data.anod_int) + RESET)

	if %KatodeFormula.text.to_lower() != data.katod_formula.to_lower():
		all_correct = false
		print(RED + "⚠ KatodeFormula: неверное значение. Ожидается: " + BOLD + str(data.katod_formula) + RESET)

	if int(%KatodNum.value) != data.katod_int:
		all_correct = false
		print(RED + "⚠ KatodNum: неверное значение. Ожидается: " + BOLD + str(data.katod_int) + RESET)

	if %IonFormula.text.to_lower() != data.ion_formula.to_lower():
		all_correct = false
		print(RED + "⚠ IonFormula: неверное значение. Ожидается: " + BOLD + str(data.ion_formula) + RESET)

	if %MolekularFormula.text.to_lower() != data.molekula_formula.to_lower():
		all_correct = false
		print(RED + "⚠ MolekularFormula: неверное значение. Ожидается: " + BOLD + str(data.molekula_formula) + RESET)
	
	if all_correct:
		print(GREEN + "✅ TaskHandler: Проверка завершена. Всё верно!" + RESET)
	else:
		print(YELLOW + "⚠️ TaskHandler: Проверка завершена. Найдены ошибки." + RESET)

	return all_correct

func handle_next():
	if GameInstance.task_id < 10:
		GameInstance.task_id += 1
		get_tree().change_scene_to_file("res://scenes/Task.tscn")

func handle_prev():
	if GameInstance.task_id > 0:
		GameInstance.task_id -= 1
		get_tree().change_scene_to_file("res://scenes/Task.tscn")
