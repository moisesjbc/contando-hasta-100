extends Node

const HINT_KEY = "hint"


var current_level_config = {
	HINT_KEY: null
}


var _level_configs = {
	0: {
		HINT_KEY: "¡Oh! ¡Hola!\n¿Podrías hacerme un favor y clicar en ese 0 de ahí abajo?",
	},
	1: {
		HINT_KEY: "¡Guay, gracias!\n¿Y qué tal con el 1?"
	}
}


func get_level_config(current_level_index: int):
	current_level_config[HINT_KEY] = null

	if current_level_index in _level_configs:
		if HINT_KEY in _level_configs[current_level_index]:
			current_level_config[HINT_KEY] = _level_configs[current_level_index][HINT_KEY]

	return current_level_config
