extends Control
class_name Playground1

@export var container: HBoxContainer

@export var color_16:ColorPalette

var _b0: ParamButton
var _b1: ParamButton
var _o0: OperatorButton
var _a0: ParamButton

var _g0: ParamButton
var _g1: ParamButton
var _o1: OperatorButton
var _a1: ParamButton

var _c0: ParamButton
var _c1: ParamButton
var _o2: OperatorButton
var _a2: ParamButton

var _ansList:Array[ParamButton] = []
var _expectedAns:Array[int] = []
var _winCount:int = 0

#var array:Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_sample()
	rand_quiz()

	pass # Replace with function body.

func init_sample():
	init_binary()
	init_grey()
	init_color()
	
	
	pass

func init_binary():
	var bContainer = $VBoxContainer/HBoxContainer
	_b0 = ParamButton.new_param_button(0, 0, false, onBinChange, false)
	_o0 = OperatorButton.new_operator_button(0, false, false, onBinChange)
	_b1 = ParamButton.new_param_button(0, 0, false, onBinChange, false)
	var o1 = OperatorButton.new_operator_button(3, true, true, onBinChange)
	_a0 = ParamButton.new_param_button(0, 0, true, onBinChange, false)
	bContainer.add_child(_b0)
	bContainer.add_child(_o0)
	bContainer.add_child(_b1)
	bContainer.add_child(o1)
	bContainer.add_child(_a0)

func init_grey():
	var gContainer = $VBoxContainer/HBoxContainer2
	_g0 = ParamButton.new_param_button(4, 1, false, onGreyChange, true)
	_o1 = OperatorButton.new_operator_button(0, false, false, onGreyChange)
	_g1 = ParamButton.new_param_button(4, 1, false, onGreyChange, true)
	var o1 = OperatorButton.new_operator_button(3, true, true, onGreyChange)
	_a1 = ParamButton.new_param_button(4, 1, true, onGreyChange, true)
	gContainer.add_child(_g0)
	gContainer.add_child(_o1)
	gContainer.add_child(_g1)
	gContainer.add_child(o1)
	gContainer.add_child(_a1)
	
func init_color():
	var cContainer = $VBoxContainer/HBoxContainer3
	_c0 = ParamButton.new_param_button(9, 2, false, onColorChange, true)
	_o2 = OperatorButton.new_operator_button(0, false, false, onColorChange)
	_c1 = ParamButton.new_param_button(9, 2, false, onColorChange, true)
	var o1 = OperatorButton.new_operator_button(3, true, true, onColorChange)
	_a2 = ParamButton.new_param_button(9, 2, true, onColorChange, true)
	cContainer.add_child(_c0)
	cContainer.add_child(_o2)
	cContainer.add_child(_c1)
	cContainer.add_child(o1)
	cContainer.add_child(_a2)
	
func rand_quiz():
	var rContainer = $HBoxContainer4
	for c in rContainer.get_children():
		c.queue_free()
	_ansList = []
	_expectedAns = []
	var opMode = randi() % 3
	var mode = randi() % 3
	match mode:
		0:
			var length = randi() % 4 + 1
			var tmpArr0 = []
			var tmpArr1 = []
			for i in range(length):
				var p0 = ParamButton.new_param_button(randi()%2, 0, true)
				var p1 = ParamButton.new_param_button(randi()%2, 0, true)
				tmpArr0.push_back(p0)
				tmpArr1.push_back(p1)
				match opMode:
					0:
						_expectedAns.push_back(p0.bitValue | p1.bitValue)
					1:
						_expectedAns.push_back(p0.bitValue & p1.bitValue)
					2:
						_expectedAns.push_back(p0.bitValue ^ p1.bitValue)
			
			for p in tmpArr0:
				rContainer.add_child(p)
			var o0 = OperatorButton.new_operator_button(opMode, true, false)
			rContainer.add_child(o0)
			for p in tmpArr1:
				rContainer.add_child(p)
			var o1 = OperatorButton.new_operator_button(3, true, false)
			rContainer.add_child(o1)
			for i in range(length):
				var p = ParamButton.new_param_button(-1, 0, false)
				rContainer.add_child(p)
				_ansList.push_back(p)
		1:
			var length = randi() % 4 + 1
			var tmpArr0 = []
			var tmpArr1 = []
			for i in range(length):
				var p0 = ParamButton.new_param_button(randi()%4+4, 1, true, null, true)
				var p1 = ParamButton.new_param_button(randi()%4+4, 1, true, null, true)
				tmpArr0.push_back(p0)
				tmpArr1.push_back(p1)
				match opMode:
					0:
						_expectedAns.push_back( ((p0.bitValue-4) | (p1.bitValue-4)) +4)
					1:
						_expectedAns.push_back( ((p0.bitValue-4) & (p1.bitValue-4))+4)
					2:
						_expectedAns.push_back( ((p0.bitValue-4) ^ (p1.bitValue-4))+4)
			
			for p in tmpArr0:
				rContainer.add_child(p)
			var o0 = OperatorButton.new_operator_button(opMode, true, false)
			rContainer.add_child(o0)
			for p in tmpArr1:
				rContainer.add_child(p)
			var o1 = OperatorButton.new_operator_button(3, true, false)
			rContainer.add_child(o1)
			for i in range(length):
				var p = ParamButton.new_param_button(-1, 1, false, null, true)
				rContainer.add_child(p)
				_ansList.push_back(p)
				
		2:
			var length = randi() % 4 + 1
			var tmpArr0 = []
			var tmpArr1 = []
			for i in range(length):
				var p0 = ParamButton.new_param_button(randi()%8+8, 2, true, null, true)
				var p1 = ParamButton.new_param_button(randi()%8+8, 2, true, null, true)
				var c0 = color_16.colors[p0.bitValue-8]
				var c1 = color_16.colors[p1.bitValue-8]
				
				tmpArr0.push_back(p0)
				tmpArr1.push_back(p1)
				match opMode:
					0: # or
						var newC:Color = Color( int(c0.r) | int(c1.r), int(c0.g) | int(c1.g), int(c0.b) | int(c1.b) )
						var idx = color_16.colors.find(newC)
						_expectedAns.push_back(idx+8)
					1: # and
						var newC:Color = Color( int(c0.r) & int(c1.r), int(c0.g) & int(c1.g), int(c0.b) & int(c1.b) )
						var idx = color_16.colors.find(newC)
						_expectedAns.push_back(idx+8)
					2: #xor
						var newC:Color = Color( int(c0.r) ^ int(c1.r), int(c0.g) ^ int(c1.g), int(c0.b) ^ int(c1.b) )
						var idx = color_16.colors.find(newC)
						_expectedAns.push_back(idx+8)
			
			for p in tmpArr0:
				rContainer.add_child(p)
			var o0 = OperatorButton.new_operator_button(opMode, true, false)
			rContainer.add_child(o0)
			for p in tmpArr1:
				rContainer.add_child(p)
			var o1 = OperatorButton.new_operator_button(3, true, false)
			rContainer.add_child(o1)
			for i in range(length):
				var p = ParamButton.new_param_button(-1, 2, false, null, true)
				rContainer.add_child(p)
				_ansList.push_back(p)
		
	rContainer.position.x = 35 - (len(_ansList)-1) * 100 
	pass

func add(a):
	#array.push_back(a)
	container.add_child(a)

func onBinChange(pValue):
	match _o0.opType:
		0: # or
			var v = _b0.bitValue | _b1.bitValue
			_a0.bitValue = v
		1: # and
			var v = _b0.bitValue & _b1.bitValue
			_a0.bitValue = v
		2: #xor
			var v = _b0.bitValue ^ _b1.bitValue
			_a0.bitValue = v
	pass

func onGreyChange(pValue):
	match _o1.opType:
		0: # or
			var v = (_g0.bitValue-4) | (_g1.bitValue -4)
			_a1.bitValue = v+4
		1: # and
			var v = (_g0.bitValue-4) & (_g1.bitValue -4)
			_a1.bitValue = v+4
		2: #xor
			var v = (_g0.bitValue-4) ^ (_g1.bitValue -4)
			_a1.bitValue = v+4
	pass

func onColorChange(pValue):
	var c0 = color_16.colors[_c0.bitValue-8]
	var c1 = color_16.colors[_c1.bitValue-8]
	match _o2.opType:
		0: # or
			var newC:Color = Color( int(c0.r) | int(c1.r), int(c0.g) | int(c1.g), int(c0.b) | int(c1.b) )
			var idx = color_16.colors.find(newC)
			_a2.bitValue = idx+8
		1: # and
			var newC:Color = Color( int(c0.r) & int(c1.r), int(c0.g) & int(c1.g), int(c0.b) & int(c1.b) )
			var idx = color_16.colors.find(newC)
			_a2.bitValue = idx+8
		2: #xor
			var newC:Color = Color( int(c0.r) ^ int(c1.r), int(c0.g) ^ int(c1.g), int(c0.b) ^ int(c1.b) )
			var idx = color_16.colors.find(newC)
			_a2.bitValue = idx+8
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func hint_error():
	print("ERROR, expected:")
	print(_expectedAns)
	for p in _ansList:
		var tween  = create_tween()
		var base = p.position
		for i in range(5):
			tween.tween_property(p, "position", Vector2(base.x + randf()*10-5, base.y), 0.02)
		tween.tween_property(p, "position", base, 0.1)

func checkAns() -> bool:
	for i in range(len(_ansList)):
		if _ansList[i].bitValue != _expectedAns[i]:
			return false
	return true

func update_win_count():
	_winCount += 1
	$WinCount.text = "Win Count: %d" % _winCount

func _on_rand_submit_pressed() -> void:
	if checkAns():
		update_win_count()
		rand_quiz()
	else:
		hint_error()
	pass # Replace with function body.
