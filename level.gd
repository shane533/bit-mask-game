extends Control

class_name Level

@export var level_id:int
@export var ans_params: Array[ParamButton]

func checkResult() -> bool:
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
		
	return false

func hint_error():
	for p in ans_params:
		var tween  = create_tween()
		var base = p.position
		for i in range(5):
			tween.tween_property(p, "position", Vector2(base.x + randf()*10-5, base.y), 0.02)
		tween.tween_property(p, "position", base, 0.1)

func checkAns(array:Array) -> bool:
	for i in range(len(array)):
		if array[i] != ans_params[i].bitValue:
			return false
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
