extends Node

var numeric_ball_scene = preload("res://gameplay/balls/numeric_ball/numeric_ball.tscn")
var operation_ball_scene = preload("res://gameplay/balls/operation_ball/operation_ball.tscn")

var selected_operation_ball = null

var first_ball_value = 0
var n_balls = 3

var operations = [
	{
		"expression_label": "+%d",
		"expression_str": "x + %d",
		"inverse_expression_str": "x - %d"
	},
	{
		"expression_label": "-%d",
		"expression_str": "x - %d",
		"inverse_expression_str": "x + %d"
	}
]

func _ready():
	var SRC_X = 200
	var DST_X = 1080
	
	var distance_between_balls = (DST_X - SRC_X) / (n_balls - 1)
	
	randomize()

	for i in range(first_ball_value, first_ball_value + n_balls):
		var numeric_ball = numeric_ball_scene.instance()
		numeric_ball.global_position = Vector2(SRC_X + i * distance_between_balls, 300)
		$balls.add_child(numeric_ball)
		numeric_ball.set_expected_value(i)
		numeric_ball.connect("numeric_ball_selected", self, "_on_numeric_ball_selected")
		
		if i > first_ball_value:
			var operation_index = randi() % len(operations)
			var current_operation = operations[operation_index]
			
			var constant = 1 + randi() % 5
			var value = _evaluate_expression(current_operation["inverse_expression_str"] % constant, i)
			numeric_ball.set_value(value)

			var operation_ball = operation_ball_scene.instance()
			
			operation_ball.global_position = Vector2(randi() % 1000, randi() % 700)
			$balls.add_child(operation_ball)
			operation_ball.set_operation(current_operation["expression_label"] % constant, current_operation["expression_str"] % constant)
			operation_ball.connect("operation_ball_selected", self, "_on_operation_ball_selected")
		else:
			numeric_ball.set_value(i)
			
			
func _evaluate_expression(expression_str: String, value: int):
	var expression = Expression.new()
	expression.parse(expression_str, ["x"])
	return expression.execute([value])

func _on_numeric_ball_selected(selected_ball):
	print("_on_numeric_ball_selected ", selected_ball)
	if selected_operation_ball:
		selected_ball.evaluate(selected_operation_ball.expression_str)
		selected_operation_ball.queue_free()
		selected_operation_ball = null
	
func _on_operation_ball_selected(ball):
	selected_operation_ball = ball
	print("_on_operation_ball_selected ", ball)
