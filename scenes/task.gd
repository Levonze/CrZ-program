extends Node
class_name TaskManager

@export var cur_task:int = 1
@export var Tasks:TaskContainer

@export var prev_btn:Button
@export var check_btn:Button
@export var next_btn:Button

func _ready() -> void:
	prev_btn.pressed.connect(handle_prev)
	check_btn.pressed.connect(handle_check)
	next_btn.pressed.connect(handle_next)
	
	if GameInstance.task_id == 9:
		next_btn.disabled = true
	
	if GameInstance.task_id == 0:
		prev_btn.disabled = true

func load_task(id:int):
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
		%ResultLabel.text = "Где-то ошибка.\n\nПишите формулы без пробелов\n❌: Pb - 2ē = Pb2+\n✅: Pb-2ē=Pb2+"
		%ResultLabel.label_settings.font_color = Color(1,0,0)

func check() -> bool:
	var data = Tasks.Tasks[cur_task]
	
	if (
		%AnodeIs.text.to_lower() == data.anod_element.to_lower() and
		%KatodeIs.text.to_lower() == data.katod_element.to_lower() and
		%AnodeFormula.text.to_lower() == data.anod_formula.to_lower() and
		int(%AnodeNum.value) == data.anod_int and
		%KatodeFormula.text.to_lower() == data.katod_formula.to_lower() and
		int(%KatodNum.value) == data.katod_int and
		%IonFormula.text.to_lower() == data.ion_formula.to_lower() and
		%MolekularFormula.text.to_lower() == data.molekula_formula.to_lower()
	):
		return true
	else:
		return false

func handle_next():
	if GameInstance.task_id < 10:
		GameInstance.task_id += 1
		get_tree().change_scene_to_file("res://scenes/Task.tscn")

func handle_prev():
	if GameInstance.task_id > 0:
		GameInstance.task_id -= 1
		get_tree().change_scene_to_file("res://scenes/Task.tscn")
