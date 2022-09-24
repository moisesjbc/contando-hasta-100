extends Node2D


var current_level: int = 0
var current_level_config = {}


func _ready():
	set_level(current_level)


func reset():
	$GUI/margin_container/hint_panel.set_hint(current_level_config[$levels_config.HINT_KEY])
	$balls_manager.set_level(
		current_level,
		current_level_config[$levels_config.N_EXTRA_VALUES]
	)


func set_level(current_level):
	self.current_level_config = $levels_config.get_level_config(current_level)
	self.current_level = current_level
	reset()


func next_level():
	set_level(current_level + 1)


func _on_balls_manager_number_selected(current_value):
	if current_level == current_value:
		if not is_victory():
			next_level()
		else:
			$GUI/center_container/game_over_panel.display(self, current_level)
	else:
		$GUI/center_container/game_over_panel.display(self, current_level)


func is_victory():
	return current_level >= 10
