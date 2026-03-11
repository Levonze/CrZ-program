extends Resource
class_name Task

@export_group("Given Data")
@export var task_data:String = "E[sub]ок[/sub]= + 0,34 В > E[sub]восст[/sub] = - 0,44 В"
@export var task_scheme:String = "Fe|O[sub]2[/sub]; H[sub]2[/sub]O| Cu"

@export_group("User Input")
@export var anod_element:String = "железо"
@export var katod_element:String = "медь"

@export var anod_formula:String
@export var katod_formula:String

@export var anod_int:int = 2
@export var katod_int:int = 1

@export var ion_formula:String
@export var molekula_formula:String
