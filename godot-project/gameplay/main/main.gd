extends Node2D


var current_expected_value: int = 0


func _ready():
	reset()


func reset():
	$GUI/margin_container/time_bar.reset()
	$balls_manager.reset()


func next_level():
	current_expected_value = current_expected_value + 1
	$balls_manager.set_level(current_expected_value)
	$GUI/margin_container/time_bar.reset()


func _on_time_bar_timeout():
	reset()


func _on_balls_manager_all_balls_right():
	next_level()


func _on_balls_manager_number_selected(current_value):
	if current_expected_value == current_value:
		next_level()
	else:
		reset()
