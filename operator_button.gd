extends TextureButton
class_name OperatorButton

@export var label: Label

var _op_type: int = 0 # 0 or ,1 and, 2 xor 
var _bit_flag: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_value() -> void:
	_op_type = (_op_type+1) % 3
	print("OPchange_value %d " % _op_type)
	if _op_type==0: # or
		self.material.set_shader_parameter("mode", 1)
		label.label_settings.font_color = Color.WHITE 
		label.text = "OR"
	elif _op_type==1: #and
		self.material.set_shader_parameter("mode", 0)
		label.label_settings.font_color = Color.BLACK
		label.text = "AND"
	elif _op_type==2: # xor
		self.material.set_shader_parameter("mode", 2)
		label.label_settings.font_color = Color.BLACK
		label.text = "XOR"

func _on_pressed() -> void:
	change_value()
	pass # Replace with function body.
