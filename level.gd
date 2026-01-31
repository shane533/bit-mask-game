extends Control

class_name Level

#@export var container: HBoxContainer

#@export var level_id:int
#@export var ans_params: Array[ParamButton]

var _ans_buttons: Array[ParamButton]

const QUESTIONS = [
	[0,-2, 0, -4,-1], #0 and 0
	[0,-2, 1, -4,-1], #0 and 1
	[1,-2, 1, -4,-1], #0 and 1
	[0,-3, 0, -4,-1], #0 or 0
	[0,-3, 1, -4,-1], #0 or 1
	[1,-3, 1, -4,-1], #0 or 1
	[0,1,0,0, -2, 1, 1, 1, 1,-4,-1,-1,-1,-1],#0100 and 1111
	[1,0,0,0, -3, 0, 0, 1, 1,-4,-1,-1,-1,-1],#1000 or 0111, #7
	[6, -2, 7,-4,-1 ], #10 and 11
	[6, -2, 4, -4,-1], #10 and 11
	[5, -3, 7, -4,-1], #01 or 11
	[5, -3, 4, -4,-1], #01 or 00
	[5, 6, -2, 7, 7, -4,-1,-1], # 01 10 and 11 11
	[6, 5, -3, 7, 7, -4,-1,-1], # 01 10 or 11 11
	[4,5,6,7, -2, 4,4,7,7, -4,-1, -1, -1, -1],# 00 01 10 11 and 00 00 11 11 #14
	[4,5,6,7, -3, 4,4,7,7, -4, -1, -1, -1, -1], # 00 01 10 11 or 00 00 11 11  #15
	[9, -2, 15, -4,-1], # red and white
	[10, -2, 8, -4,-1], # green and black
	[11, -3, 15, -4,-1], #blue or white
	[12, -3, 8, -4,-1], #cyan or black
	[9, -3, 10, -4,-1], # red or green ->yellow 14
	[11, -3, 10, -4,-1], # blue or green -> cyan 12
	[9, -2, 10, -4,-1], # red and green -> black 8
	[14, -2, 13, -4,-1], # yellow and purple -> red 9
]

func checkResult(level_id) -> bool:
	match level_id:
		0:
			return checkAns([0])
		1:
			return checkAns([0])
		2:
			return checkAns([1])
		3:	
			return checkAns([0])
		4:	
			return checkAns([1])
		5:	
			return checkAns([1])
		6:	
			return checkAns([0,1,0,0])
		7:	
			return checkAns([1,0,1,1])
		8:
			return checkAns([6])
		9:
			return checkAns([4])
		10:
			return checkAns([7])
		11:
			return checkAns([5])
		12:
			return checkAns([5,6])
		13:
			return checkAns([7,7])
		14:
			return checkAns([4,4,6,7])
		15:
			return checkAns([4,5,7,7])
		16:
			return checkAns([9])
		17:
			return checkAns([8])
		18:
			return checkAns([15])
		19:
			return checkAns([12])
		20:
			return checkAns([14])
		21:
			return checkAns([12])
		22:
			return checkAns([8])
		23:
			return checkAns([9])
		
	return false

func hint_error():
	for p in _ans_buttons:
		var tween  = create_tween()
		var base = p.position
		for i in range(5):
			tween.tween_property(p, "position", Vector2(base.x + randf()*10-5, base.y), 0.02)
		tween.tween_property(p, "position", base, 0.1)
		
		

func checkAns(array:Array) -> bool:
	#return true;
	for i in range(len(array)):
		if array[i] != _ans_buttons[i].bitValue:
			return false
	return true

func init_level(level:int):
	#container.rem
	print("Init Level %d" % level)
	_ans_buttons = []
	var question = QUESTIONS[level]
	var container = $HBoxContainer
	for i in question:
		print("Try add button  %d" % i)
		match i:
			0,1:
				var b = ParamButton.new_param_button(i, 0, true)
				container.add_child(b)
			4,5,6,7:
				var b = ParamButton.new_param_button(i, 1, true, null, level>=12)
				container.add_child(b)
			8,9,10,11,12,13,14,15:
				var b = ParamButton.new_param_button(i, 2, true, null, true)
				container.add_child(b)
			-2:
				var b = OperatorButton.new_operator_button(1, true, true)
				container.add_child(b)
			-3:
				var b = OperatorButton.new_operator_button(0, true, true)
				container.add_child(b)
			-4:
				var b = OperatorButton.new_operator_button(3, true, true)
				container.add_child(b)
			-1:
				var mode = 0 if level < 8 else (1 if level < 16 else 2)
				var b = ParamButton.new_param_button(-1, mode, false, null, level>=12)
				container.add_child(b)
				_ans_buttons.push_back(b)
				

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
