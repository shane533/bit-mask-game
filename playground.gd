extends Control
class_name Playground1

@export var container: HBoxContainer

var _p1: ParamButton
var _p2: ParamButton
var _p3: ParamButton
var _p4: ParamButton
var _p5: ParamButton
var _p6: ParamButton
var _o1: OperatorButton
var _o2: OperatorButton

#var array:Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_p1 = ParamButton.new_param_button(0, 0, false, onChange)
	_p2 = ParamButton.new_param_button(0, 0, false, onChange)
	_o1 = OperatorButton.new_operator_button(0, false, true, onChange)
	_p3 = ParamButton.new_param_button(0, 0, false, onChange)
	_p4 = ParamButton.new_param_button(0, 0, false, onChange)
	_o2 = OperatorButton.new_operator_button(3, true, false, onChange)
	_p5 = ParamButton.new_param_button(0, 0, true, onChange)
	_p6 = ParamButton.new_param_button(0, 0, true, onChange)
	add(_p1)
	add(_p2)
	add(_o1)
	add(_p3)
	add(_p4)
	add(_o2)
	add(_p5)
	add(_p6)
	
	pass # Replace with function body.

func add(a):
	#array.push_back(a)
	container.add_child(a)

func onChange(param):
	if _o1.opType == 0:
		var p5 = _p1.bitValue | _p3.bitValue
		_p5.bitValue = p5 
		var p6 = _p2.bitValue | _p4.bitValue
		_p6.bitValue = p6 
	elif _o1.opType == 1:
		var p5 = _p1.bitValue & _p3.bitValue
		_p5.bitValue = p5 
		var p6 = _p2.bitValue & _p4.bitValue
		_p6.bitValue = p6 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
