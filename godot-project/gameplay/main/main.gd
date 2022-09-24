extends Node2D


var current_level: int = 0
var current_level_config = {}

const TrickType = preload("res://globals/trick_type.gd").TrickType
var LevelConfigKey = preload("res://gameplay/levels_config/levels_config.gd").LevelConfigKey

func _ready():
	# set_level(current_level)
	# TODO: Remove development trick
	for i in range(0, 44):
		current_level = i
		$levels_config.get_level_config(i)
	set_level(44)
	
	
func reset_hint():
	var current_hint = current_level_config[LevelConfigKey.HINT]
	if not current_hint and current_level_config[LevelConfigKey.TRICK] == TrickType.HINT_TEXT:
		current_hint = "¡DALE CAÑA A ESE %d!" % get_random_number()

	$GUI/hint_panel.set_hint(current_hint)


func reset_background():
	$taunt_background.clear()
	
	if current_level_config[LevelConfigKey.TRICK] == TrickType.BACKGROUND_NUMBER:
		$taunt_background.repeat_number(get_random_number())


func reset_notification():
	$notification.set_active(current_level_config[LevelConfigKey.TRICK] == TrickType.NOTIFICATION, get_random_number())


func reset():
	reset_background()
	reset_hint()
	reset_notification()
	$balls_manager.set_level(
		current_level,
		current_level_config[LevelConfigKey.N_EXTRA_VALUES],
		current_level_config[LevelConfigKey.TRICK]
	)


func set_level(current_level):
	self.current_level_config = $levels_config.get_level_config(current_level)
	self.current_level = current_level
	reset()


func next_level():
	set_level(current_level + 1)


func _on_balls_manager_number_selected(selected_value):
	if current_level == selected_value:
		if not is_victory():
			next_level()
		else:
			$GUI/game_over_screen.display(self, selected_value, current_level, null)
	else:
		$GUI/game_over_screen.display(self, selected_value, current_level, current_level_config[LevelConfigKey.GAME_OVER_TAUNT])


func is_victory():
	return current_level >= 55


func get_random_number():
	randomize()
	return current_level - current_level_config[LevelConfigKey.N_EXTRA_VALUES] + randi() % (current_level_config[LevelConfigKey.N_EXTRA_VALUES] * 2 + 1)
