extends Node2D


var current_level: int = 0
var current_level_config = {}

const TrickType = preload("res://globals/trick_type.gd").TrickType


func _ready():
	#set_level(current_level)
	# TODO: Remove development trick
	for i in range(0, 12):
		current_level = i
		$levels_config.get_level_config(i)
	set_level(12)
	
	
func reset_hint():
	var current_hint = current_level_config[$levels_config.HINT_KEY]
	if not current_hint and current_level_config[$levels_config.TRICK] == TrickType.HINT_TEXT:
		var n_extra_values = current_level_config[$levels_config.N_EXTRA_VALUES]
		current_hint = "¡DALE CAÑA A ESE %d!" % ((current_level - 1) + randi() % 3)

	$GUI/margin_container/hint_panel.set_hint(current_hint)


func reset():
	reset_hint()
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
	return current_level >= 25
