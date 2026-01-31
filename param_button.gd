@tool
extends TextureButton

class_name ParamButton

signal s_param_button_clicked(b)

@export var label: Label

@export var isFixed: bool = false

@export var dataMode: int = 0; #0 bin, 1 grey, 2 16color

@export var colorPallete:ColorPalette

@export var hideLabel: bool = false

@export var bitValue: int = 0:
	set(v):
		#print("CALL SET")
		bitValue = v
		update_value()

const param_button_tscn = preload("res://param_button.tscn")

func init(pDefault:int, pDataMode:int, pFixed:bool, pHideLabel:bool=false):
	bitValue = pDefault
	dataMode = pDataMode
	isFixed = pFixed
	hideLabel = pHideLabel
	update_value()
	
static func new_param_button(pDefault:int, pDataMode:int, pFixed:bool, pCallback=null, pHideLabel:bool=false) -> ParamButton:
	var pb:ParamButton = param_button_tscn.instantiate()
	pb.init(pDefault, pDataMode, pFixed, pHideLabel)
	if pCallback:
		pb.s_param_button_clicked.connect(pCallback)
	return pb
	
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
	print("UPDATE_VALUE %d %d" % [dataMode, bitValue])
	label.visible = (not hideLabel) or (bitValue == -1)
	match bitValue:
		-1:
			#print("-1")
			self.material.set_shader_parameter("mode", 4)
			label.label_settings.font_color = Color.WHITE 
			label.label_settings.font_size = 64
			label.text = "?"
		1:
			self.material.set_shader_parameter("mode", 7)
			label.label_settings.font_color = Color.BLACK 
			label.label_settings.font_size = 64
			label.text = "1"
		0:
			self.material.set_shader_parameter("mode", 4)
			label.label_settings.font_color = Color.WHITE
			label.label_settings.font_size = 64
			label.text = "0"
		4:
			self.material.set_shader_parameter("mode", 4)
			label.label_settings.font_color = Color.WHITE
			label.label_settings.font_size = 48
			label.text = "00"
		5:
			self.material.set_shader_parameter("mode", 5)
			label.label_settings.font_color = Color.WHITE
			label.label_settings.font_size = 48
			label.text = "01"
		6:
			self.material.set_shader_parameter("mode", 6)
			label.label_settings.font_color = Color.BLACK
			label.label_settings.font_size = 48
			label.text = "10"
		7:
			self.material.set_shader_parameter("mode", 7)
			label.label_settings.font_color = Color.BLACK
			label.label_settings.font_size = 48
			label.text = "11"
		8,9,10,11,12,13,14,15:
			#print("COLOR P")
			self.material.set_shader_parameter("mode", 8)
			if bitValue == 8:
				label.label_settings.font_color = Color.WHITE
			else:
				label.label_settings.font_color = Color.BLACK
			self.self_modulate = colorPallete.colors[bitValue-8]
			label.label_settings.font_size = 48
			label.text = str(bitValue-8)
			

func change_value() -> void:
	if bitValue == -1:
		match dataMode:
			0:
				bitValue = 0
			1:
				bitValue = 4
			2:
				bitValue = 8
	else:
		match dataMode:
			0:
				bitValue = (bitValue+1)%2
			1:
				bitValue = (bitValue-4+1)%4 + 4
			2:
				bitValue = (bitValue-8+1)%8 + 8
		
	update_value()

func _on_pressed() -> void:
	if not isFixed:
		change_value()
		s_param_button_clicked.emit(bitValue)
	pass # Replace with function body.
