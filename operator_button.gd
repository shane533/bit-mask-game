@tool
extends TextureButton
class_name OperatorButton

signal s_operator_button_clicked(d)

@export var label: Label

@export var isFixed:bool = false
@export var isTwoMode:bool = true
@export var opType: int = 0:
	set(op):
		opType = op # 0 or ,1 and, 2 xor 
		update_value()
var _bit_flag: bool = true

const operator_button_tscn = preload("res://operator_button.tscn")

func init(pDefault:int, pFixed:bool, pIsTwoMode:bool):
	opType = pDefault
	isFixed = pFixed
	isTwoMode = pIsTwoMode
	update_value()
	
static func new_operator_button(pDefault:int, pFixed:bool, pIsTwoMode:bool, pCallback=null) -> OperatorButton:
	var ob:OperatorButton = operator_button_tscn.instantiate()
	ob.init(pDefault, pFixed, pIsTwoMode)
	if pCallback:
		ob.s_operator_button_clicked.connect(pCallback)
	return ob


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_value()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_value() -> void:
	if not is_node_ready():
		return
	match opType:
		0: # or
			self.material.set_shader_parameter("mode", 1)
			label.label_settings.font_color = Color.WHITE 
			label.label_settings.font_size = 30
			label.text = "OR"
		1: #and
			self.material.set_shader_parameter("mode", 0)
			label.label_settings.font_color = Color.BLACK
			label.label_settings.font_size = 30
			label.text = "AND"
		2: # xor
			self.material.set_shader_parameter("mode", 2)
			label.label_settings.font_color = Color.BLACK
			label.label_settings.font_size = 30
			label.text = "XOR"
		3: #=
			self.material.set_shader_parameter("mode", 0)
			label.label_settings.font_color = Color.BLACK
			label.label_settings.font_size = 36
			label.text = "="

func change_value() -> void:
	opType = (opType+1) % (2 if isTwoMode else 3)
	print("OPchange_value %d " % opType)
	

func _on_pressed() -> void:
	if not isFixed:
		change_value()
		s_operator_button_clicked.emit(opType)
	pass # Replace with function body.
