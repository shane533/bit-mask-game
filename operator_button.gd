extends TextureButton

@export var label: Label

var _bit_flag: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_value() -> void:
	_bit_flag = !_bit_flag
	if _bit_flag:
		self.material.set_shader_parameter("mode", 1)
		label.label_settings.font_color = Color.WHITE 
		label.text = "1"
	else:
		self.material.set_shader_parameter("mode", 0)
		label.label_settings.font_color = Color.BLACK
		label.text = "0"

func _on_pressed() -> void:
	
	change_value()
	pass # Replace with function body.
