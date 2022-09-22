extends Node


var initial_n_numeric_balls = 2
var number_increasing_n_numeric_balls = [
	2,
	60
]

var initial_n_extra_operation_balls = 0
var number_increasing_n_extra_operation_balls = [
	10,
	50
]

func get_n_numeric_balls(initial_number: int):
	return _get_n_balls(initial_number, initial_n_numeric_balls, number_increasing_n_numeric_balls)


func get_n_extra_operation_balls(initial_number: int):
	return _get_n_balls(initial_number, initial_n_extra_operation_balls, number_increasing_n_extra_operation_balls)


func _get_n_balls(initial_ball_number: int, initial_value: int, array):
	var i = 0
	while i < len(number_increasing_n_numeric_balls) and initial_ball_number > array[i]:
		i = i + 1
	return initial_value + i
