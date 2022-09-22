extends Node2D


var current_initial_value: int = 0

func _ready():
	reset()


func reset():
	$GUI/margin_container/time_bar.reset()
	$balls_manager.set_level(
		current_initial_value,
		$difficulty_manager.get_n_numeric_balls(current_initial_value),
		$difficulty_manager.get_n_extra_operation_balls(current_initial_value)
	)


func next_level():
	current_initial_value = $balls_manager.last_ball_value()
	reset()


func _on_time_bar_timeout():
	reset()


func _on_balls_manager_all_balls_right():
	next_level()
