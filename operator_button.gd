@tool
extends TextureButton
class_name OperatorButton

@export var label: Label

@export var isFixed:bool = false
@export var opType: int = 0:
	set(op):
		opType = op # 0 or ,1 and, 2 xor 
		update_value()
var _bit_flag: bool = true

const operator_button_tscn = preload("res://operator_button.tscn")

func init(pDefault:bool, pFixed:bool):
	opType = pDefault
	isFixed = pFixed
	update_value()
	
static func new_operator_button(pDefault:bool, pFixed:bool) -> OperatorButton:
	var ob:OperatorButton = operator_button_tscn.instantiate()
	ob.init(pDefault, pFixed)
	return ob


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_value() -> void:
	match opType:
		0: # or
			self.material.set_shader_parameter("mode", 1)
			label.label_settings.font_color = Color.WHITE 
			label.text = "OR"
		1: #and
			self.material.set_shader_parameter("mode", 0)
			label.label_settings.font_color = Color.BLACK
			label.text = "AND"
		2: # xor
			self.material.set_shader_parameter("mode", 2)
			label.label_settings.font_color = Color.BLACK
			label.text = "XOR"

func change_value() -> void:
	opType = (opType+1) % 3
	print("OPchange_value %d " % opType)
	

func _on_pressed() -> void:
	if not isFixed:
		change_value()
	pass # Replace with function body.
