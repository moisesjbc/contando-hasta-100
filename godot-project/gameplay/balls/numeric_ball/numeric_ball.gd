extends Area2D


signal numeric_ball_selected

var value = null
var expected_value = null


func _update_color():
	if value == expected_value:
		modulate = Color.green
	else:
		modulate = Color.red


func set_value(new_value: int):
	value = new_value
	$label.bbcode_text = "[center]" + str(value) + "[/center]"
	_update_color()


func set_expected_value(new_expected_value: int):
	expected_value = new_expected_value
	_update_color()


func _on_numeric_ball_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("numeric_ball_selected", self)


func evaluate(expression_str: String):
	var expression = Expression.new()
	expression.parse(expression_str, ["x"])
	var result = expression.execute([value])
	set_value(result)
