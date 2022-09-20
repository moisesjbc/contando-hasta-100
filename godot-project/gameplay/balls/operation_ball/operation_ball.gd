extends Area2D


signal operation_ball_selected


var expression_label = "x2"
var expression_str = "2 * x"
var expression = Expression.new()


func _ready():
	$label.bbcode_text = "[center]" + expression_label + "[/center]"


func _on_operation_ball_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("operation_ball_selected", self)
