extends Area2D


signal numeric_ball_selected

var value = null


func set_value(new_value: int):
	value = new_value
	$label.bbcode_text = "[center]" + str(value) + "[/center]"


func _on_numeric_ball_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("numeric_ball_selected", self)
