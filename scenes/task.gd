extends Node
class_name TaskManager

@export var cur_task:int = 1
@export var Tasks:TaskContainer

@export var check_btn:Button
@export var next_btn:Button

func _ready() -> void:
	check_btn.pressed.connect(handle_check)
	next_btn.pressed.connect(handle_next)

func load_task(id:int):
	print(id)
	var data = Tasks.Tasks[int(id - 1)]
	cur_task = id
	
	%TaskElement.text = data.task_data
	%GalvanicElement.text = data.task_scheme
	
	clear_fields()
	
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
		%NextTask.disabled = false
	else:
		%ResultLabel.text = "Где-то ошибка.\n\nПишите формулы без пробелов\n❌: Pb - 2ē = Pb2+\n✅: Pb-2ē=Pb2+"
		%ResultLabel.label_settings.font_color = Color(1,0,0)
		%NextTask.disabled = true

func check() -> bool:
	var data = Tasks.Tasks[cur_task - 1]
	
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
