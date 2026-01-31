extends Control

class_name Main

@export var level: int = 0
@export var level_label: Label

@export var shaderables:Array[CanvasItem]

@export var ruleArray:Array[HBoxContainer]

@export var levels:Array[Level]

const MAX_LEVEL: int = 8

func checkLevelAnswer() -> bool:
	return levels[level].checkResult()

func show_next_level():
	if level < MAX_LEVEL:
		level += 1
		update_levels()
	return 
	
func hint_error():
	print("WRONG ANSWER!!")
	levels[level].hint_error()
	return

func _on_submit_pressed() -> void:
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
			show_next_level()
		7:
			var tween = create_tween()
	

func show_rule():
	ruleArray[level].visible = true
		
func update_levels():
	var str = String.num_uint64(level, 2)
	print("UpdateLevels %d" % level )
	level_label.text = "Level %s" % str
	for l in levels:
		l.visible = (l.level_id == level)
	if level < 6:
		change_shader_param(1)
	else:
		change_shader_param(2)
		
func change_shader_param(p):
	for c in shaderables:
		c.material.set_shader_parameter("mode", p)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_levels()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
