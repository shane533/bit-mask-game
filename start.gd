extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in [0, 1]:
		var b = ParamButton.new_param_button(i, 0, true)
		$VBoxContainer2/HBoxContainer5.add_child(b)
	for i in [4,5,6,7]:
		var g = ParamButton.new_param_button(i, 1, true, null, true)
		$VBoxContainer2/HBoxContainer6.add_child(g)
	for i in [8,9,10,11,12,13,14,15]:
		var c = ParamButton.new_param_button(i, 2, true, null, true)
		$VBoxContainer2/HBoxContainer7.add_child(c)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
