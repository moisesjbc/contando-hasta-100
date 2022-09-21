extends Node2D


func reset():
	$GUI/margin_container/time_bar.reset()
	$balls_manager.reset()


func next_level():
	$GUI/margin_container/time_bar.next_level()
	$balls_manager.next_level()


func _on_time_bar_timeout():
	reset()


func _on_balls_manager_all_balls_right():
	next_level()
