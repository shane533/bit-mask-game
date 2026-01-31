@tool
extends TextureButton

class_name ParamButton

@export var label: Label

@export var isFixed: bool = false

@export var bitFlag: bool = true:
	set(v):
		#print("CALL SET")
		bitFlag = v
		update_value()

const param_button_tscn = preload("res://param_button.tscn")

func init(pDefault:bool, pFixed:bool):
	bitFlag = pDefault
	isFixed = pFixed
	update_value()
	
static func new_param_button(pDefault:bool, pFixed:bool) -> ParamButton:
	var pb:ParamButton = param_button_tscn.instantiate()
	pb.init(pDefault, pFixed)
	return pb
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_value() -> void:
	if bitFlag:
		self.material.set_shader_parameter("mode", 1)
		label.label_settings.font_color = Color.WHITE 
		label.text = "1"
	else:
		self.material.set_shader_parameter("mode", 0)
		label.label_settings.font_color = Color.BLACK
		label.text = "0"

func change_value() -> void:
	bitFlag = !bitFlag
	update_value()

func _on_pressed() -> void:
	if not isFixed:
		change_value()
	pass # Replace with function body.
