extends Node2D


var current_level: int = 0
var current_level_config = {}

const TrickType = preload("res://globals/trick_type.gd").TrickType
var LevelConfigKey = preload("res://gameplay/levels_config/levels_config.gd").LevelConfigKey

func _ready():
	# set_level(current_level)
	# TODO: Remove development trick
	for i in range(0, 12):
		current_level = i
		$levels_config.get_level_config(i)
	set_level(12)
	
	
func reset_hint():
	var current_hint = current_level_config[LevelConfigKey.HINT]
	if not current_hint and current_level_config[LevelConfigKey.TRICK] == TrickType.HINT_TEXT:
		var n_extra_values = current_level_config[LevelConfigKey.N_EXTRA_VALUES]
		current_hint = "¡DALE CAÑA A ESE %d!" % ((current_level - 1) + randi() % 3)

	$GUI/hint_panel.set_hint(current_hint)


func reset():
	reset_hint()
	$balls_manager.set_level(
		current_level,
		current_level_config[LevelConfigKey.N_EXTRA_VALUES]
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
			$GUI/game_over_screen.display(self, current_value, current_level, null)
	else:
		$GUI/game_over_screen.display(self, current_value, current_level, current_level_config[LevelConfigKey.GAME_OVER_TAUNT])


func is_victory():
	return current_level >= 25
