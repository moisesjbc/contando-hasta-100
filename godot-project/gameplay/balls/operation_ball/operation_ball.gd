extends Area2D


signal operation_ball_selected


var expression_label = null
var expression_str = null
	

func set_operation(new_expression_label: String, new_expression_str: String):
	expression_label = new_expression_label
	expression_str = new_expression_str
	$label.bbcode_text = "[center]" + expression_label + "[/center]"


func _on_operation_ball_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("operation_ball_selected", self)
