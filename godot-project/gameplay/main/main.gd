extends Node2D


var current_expected_value: int = 0


func _ready():
	reset()


func reset():
	$balls_manager.set_level(current_expected_value)


func set_level(current_expected_value):
	self.current_expected_value = current_expected_value
	reset()


func next_level():
	set_level(current_expected_value + 1)


func _on_balls_manager_number_selected(current_value):
	if current_expected_value == current_value:
		if not is_victory():
			next_level()
		else:
			$GUI/center_container/game_over_panel.display(self, current_expected_value)
	else:
		$GUI/center_container/game_over_panel.display(self, current_expected_value)


func is_victory():
	return current_expected_value >= 10
