extends Node

var numeric_ball_scene = preload("res://gameplay/balls/numeric_ball/numeric_ball.tscn")
var operation_ball_scene = preload("res://gameplay/balls/operation_ball/operation_ball.tscn")

var selected_operation_ball = null

signal all_balls_right

var first_ball_value = 0
var n_balls = 3
var n_right_balls = 1

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

func set_level(new_first_ball_value: int, new_n_balls: int):
	first_ball_value = new_first_ball_value
	new_n_balls = new_n_balls
	
	reset()


func reset():
	var SRC_X = 200
	var DST_X = 1080
	
	n_right_balls = 1
	
	var distance_between_balls = (DST_X - SRC_X) / (n_balls - 1)
	
	randomize()
	
	for ball in $balls.get_children():
		$balls.remove_child(ball)
		ball.queue_free()

	for i in range(first_ball_value, first_ball_value + n_balls):
		var numeric_ball = numeric_ball_scene.instance()
		numeric_ball.global_position = Vector2(SRC_X + (i - first_ball_value) * distance_between_balls, 350)
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

func _ready():
	reset()

func _evaluate_expression(expression_str: String, value: int):
	var expression = Expression.new()
	expression.parse(expression_str, ["x"])
	return expression.execute([value])

func _on_numeric_ball_selected(selected_ball):
	if selected_operation_ball:
		selected_ball.evaluate(selected_operation_ball.expression_str)
		selected_operation_ball.queue_free()
		selected_operation_ball = null
		if selected_ball.has_expected_value():
			n_right_balls += 1
			if n_right_balls == n_balls:
				emit_signal("all_balls_right")
		else:
			reset()
	
func _on_operation_ball_selected(ball):
	selected_operation_ball = ball


func next_level():
	set_level(first_ball_value + n_balls - 1, n_balls)
