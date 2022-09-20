extends Area2D


signal numeric_ball_selected

var number = 1

func _ready():
	set_number(1)


func set_number(new_number: int):
	number = new_number
	$label.bbcode_text = "[center]" + str(number) + "[/center]"


func _on_numeric_ball_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("numeric_ball_selected", self)


func evaluate(expression_str: String):
	var expression = Expression.new()
	expression.parse(expression_str, ["x"])
	var result = expression.execute([number])
	set_number(result)
