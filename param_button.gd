@tool
extends TextureButton

class_name ParamButton

signal s_param_button_clicked(b)

@export var label: Label

@export var isFixed: bool = false

@export var bitValue: int = 0:
	set(v):
		#print("CALL SET")
		bitValue = v
		update_value()

const param_button_tscn = preload("res://param_button.tscn")

func init(pDefault:int, pFixed:bool):
	bitValue = pDefault
	isFixed = pFixed
	update_value()
	
static func new_param_button(pDefault:int, pFixed:bool, pCallback=null) -> ParamButton:
	var pb:ParamButton = param_button_tscn.instantiate()
	pb.init(pDefault, pFixed)
	pb.s_param_button_clicked.connect(pCallback)
	return pb
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_value() -> void:
	print("UPDATE_VALUE " )
	match bitValue:
		-1:
			self.material.set_shader_parameter("mode", 1)
			label.label_settings.font_color = Color.WHITE 
			label.text = "?"
		1:
			self.material.set_shader_parameter("mode", 1)
			label.label_settings.font_color = Color.WHITE 
			label.text = "1"
		0:
			self.material.set_shader_parameter("mode", 0)
			label.label_settings.font_color = Color.BLACK
			label.text = "0"

func change_value() -> void:
	if bitValue == -1:
		bitValue = 0
	else:
		bitValue = (bitValue+1)%2
	update_value()

func _on_pressed() -> void:
	if not isFixed:
		change_value()
		s_param_button_clicked.emit(bitValue)
	pass # Replace with function body.
