extends Control

class_name Main

@export var level: int = 0
@export var level_label: Label
@export var rule_bin: Control
@export var rule_grey: Control
@export var rule_color: Control

@export var h_box_container_5: HBoxContainer
@export var h_box_container_6: HBoxContainer
@export var h_box_container_7: HBoxContainer

@export var hint_label: Label

@export var shaderables:Array[CanvasItem]

@export var ruleArray:Array[HBoxContainer]

@export var levels:Array[Level]

const MAX_LEVEL: int = 23

const RULES = [
	[0,-2, 0, -4, 0], #0 and 0
	[0,-2, 1, -4, 0], #0 and 1
	[1,-2, 1, -4, 1], #0 and 1
	[0,-3, 0, -4, 0], #0 or 0
	[0,-3, 1, -4, 1], #0 or 1
	[1,-3, 1, -4, 1], #0 or 1
	[0,1,0,0, -2, 1, 1, 1, 1,-4,-1,-1,-1,-1],#0100 and 1111
	[1,0,0,0, -3, 0, 0, 1, 1,-4,-1,-1,-1,-1],#1000 or 0111, #7
	[6, -2, 7,-4, 6 ], #10 and 11
	[6, -2, 4, -4, 4], #10 and 00
	[5, -3, 7, -4, 7], #01 or 11
	[5, -3, 4, -4, 5], #01 or 00
	[5, 6, -2, 7, 7, -4,-1,-1], # 01 10 and 11 11
	[6, 5, -3, 7, 7, -4,-1,-1], # 01 10 or 11 11
	[4,5,6,7, -2, 4,4,7,7, -4,-1, -1, -1, -1],# 00 01 10 11 and 00 00 11 11 #14
	[4,5,6,7, -3, 4,4,7,7, -4, -1, -1, -1, -1], # 00 01 10 11 or 00 00 11 11  #15
	[9, -2, 15, -4, 9], # red and white
	[10, -2, 8, -4, 8], # green and black
	[11, -3, 15, -4,15], #blue or white
	[12, -3, 8, -4,12], #cyan or black
	[9, -3, 10, -4,-1], # red or green ->yellow 14
	[11, -3, 10, -4,-1], # blue or green -> cyan 12
	[9, -2, 10, -4,-1], # red and green -> black 8
	[14, -2, 13, -4,-1], # yellow and purple -> red 9
]

const HINTS = [
	
	"Click ? to try it out!",
	"Click ? to try it out!",
	"Do you know, eveything in \ncomputer is about 1 and 0",
	"Do you know, eveything in \ncomputer is about 1 and 0",
	"It's not the MASK you expected\n right?",
	"It's not the MASK you expected\n right?",
	"But, it is MASK, and it's critical！",
	"But, it is MASK, and it's critical！",
	"Do you know, Game Boy \ndisplay 4 shades of gray",
	"Do you know, Game Boy \ndisplay 4 shades of gray",
	"Yes, there's a XOR, \nbut I won't introduce it",
	"Yes, there's a XOR, \nbut I won't introduce it",
	"You don't need 01 to \nsolve it, right?",
	"You don't need 01 to \nsolve it, right?",
	"Black/white masks are\n widely used in image processing",
	"Black/white masks are \nwidely used in image processing",
	"Yes, we finally got some color!",
	"Yes, we finally got some color!",
	"Some old computer can \nonly display 8/16 colors",
	"Some old computer can \nonly display 8/16 colors",
	"It was supposed to \nhave more levels",
	"But I'm running \nout of time",
	"So I guess that it",
	"Thank you for playing",
]

func checkLevelAnswer() -> bool:
	return levels[level].checkResult(level)

func show_next_level():
	if level < MAX_LEVEL:
		level += 1
		update_levels()
	return 
	
func hint_error():
	print("WRONG ANSWER!! %d" % level)
	levels[level].hint_error()
	return

func _on_submit_pressed() -> void:
	#show_combine_anim()
	#return
	var result:bool = checkLevelAnswer()
	if result:
		play_pass_anim()
	else:
		hint_error()
		
func play_pass_anim():
	match level:
		
		0,1,2,3,4,5:
			var offsetY = 68
			var dest = Vector2(-70 if level < 3 else 70, 141 + (level%3)*offsetY)
			var l:Level = levels[level]
			
			var tween = create_tween()
			tween.tween_property(l, "global_position", dest, 0.5)
			tween.tween_callback(show_rule)
			tween.tween_callback(show_next_level)
		6:
			fade_and_next()
		7:
			show_combine_anim()
		8,9,10,11:
			var offsetY = 68
			var dest = Vector2(-70 if level < 10 else 70, 141 + (level%2)*offsetY)
			var l:Level = levels[level]
			
			var tween = create_tween()
			tween.tween_property(l, "global_position", dest, 0.5)
			tween.tween_callback(show_rule)
			tween.tween_callback(show_next_level)
		12,13,14:
			fade_and_next()
		15:
			fade_and_next()
		16,17,18,19:
			var offsetY = 68
			var dest = Vector2(-70 if level < 18 else 70, 141 + (level%2)*offsetY)
			var l:Level = levels[level]
			
			var tween = create_tween()
			tween.tween_property(l, "global_position", dest, 0.5)
			tween.tween_callback(show_rule)
			tween.tween_callback(show_next_level)
			#show_combine_anim()
		20,21,22:
			fade_and_next()
		23:
			show_win()
			
func show_win():
	print("WIN")
			
func fade_and_next():
	var tween = create_tween()
	tween.tween_property(levels[level], "modulate:a", 0, 1)
	tween.tween_callback(show_next_level)
	
func show_combine_anim():
	var l = levels[level]
	var p0 = ParamButton.new_param_button(1, 0, 1)
	p0.position = Vector2(682, 0)
	l.add_child(p0)
	var p1 = ParamButton.new_param_button(0, 0, 1)
	p1.position = Vector2(749, 0)
	l.add_child(p1)
	var p2 = ParamButton.new_param_button(1, 0, 1)
	p2.position = Vector2(818, 0)
	l.add_child(p2)
	var p3 = ParamButton.new_param_button(1, 0, 1)
	p3.position = Vector2(885, 0)
	l.add_child(p3)
	var tween0 = create_tween()
	
	tween0.tween_property(p0, "position", Vector2(p0.position.x-400, p0.position.y-40), 1)
	tween0.parallel().tween_property(p1, "position", Vector2(p1.position.x-400, p1.position.y-40), 1)
	tween0.parallel().tween_property(p2, "position", Vector2(p2.position.x-400, p2.position.y-40), 1)
	tween0.parallel().tween_property(p3, "position", Vector2(p3.position.x-400, p3.position.y-40), 1)
	tween0.tween_property(p0, "position", Vector2(p0.position.x-360, p0.position.y-40), 1)
	tween0.parallel().tween_property(p1, "position", Vector2(p1.position.x-440, p0.position.y-40), 1)
	tween0.parallel().tween_property(p2, "position", Vector2(p2.position.x-360, p0.position.y-40), 1)
	tween0.parallel().tween_property(p3, "position", Vector2(p3.position.x-440, p0.position.y-40), 1)
	tween0.tween_callback(show_next_level)

func show_rule():
	var question = RULES[level]
	var container = ruleArray[level]
	 
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
	
		
func update_levels():
	var str = String.num_uint64(level, 2)
	print("UpdateLevels %d" % level )
	level_label.text = "Level %s" % str
	hint_label.text = HINTS[level]
	for i in len(levels):
		var l = levels[i]
		l.visible = (i == level)
	levels[level].init_level(level)
	if level < 8:
		h_box_container_5.visible = true
		change_shader_param(1)
	elif level < 16:
		h_box_container_6.visible = true
		change_shader_param(2)
	else:
		h_box_container_7.visible = true
		change_shader_param(8)
		
	rule_bin.visible = level < 8
	rule_grey.visible = level >= 8 and level < 16
	rule_color.visible = level >= 16
	
		
func change_shader_param(p):
	for c in shaderables:
		c.material.set_shader_parameter("mode", p)

func init_banner():
	for i in [0, 1]:
		var b = ParamButton.new_param_button(i, 0, true)
		h_box_container_5.add_child(b)
	for i in [4,5,6,7]:
		var g = ParamButton.new_param_button(i, 1, true, null, true)
		h_box_container_6.add_child(g)
	for i in [8,9,10,11,12,13,14,15]:
		var c = ParamButton.new_param_button(i, 2, true, null, true)
		h_box_container_7.add_child(c)
	h_box_container_5.visible = false
	h_box_container_6.visible = false
	h_box_container_7.visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_banner()
	update_levels()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	$Start.visible = false
	pass # Replace with function body.
