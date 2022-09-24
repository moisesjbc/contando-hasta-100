extends Node


const HINT_KEY = "hint"
const N_EXTRA_VALUES = 0


var current_level_config = {
	HINT_KEY: null,
	N_EXTRA_VALUES: 0
}


var _level_configs = {
	0: {
		HINT_KEY: "¡Oh! ¡Hola!\n¿Podrías hacerme un favor y presionar sobre ese 0 de ahí abajo?",
	},
	1: {
		HINT_KEY: "¡Guay, gracias!\n¿Y qué tal con el 1?"
	},
	2: {
		HINT_KEY: "¡Perfecto!¿Podrías clicar ahora en...?\n No me acuerdo, ¿cuál iba ahora?",
		N_EXTRA_VALUES: 2
	},
	3: {
		HINT_KEY: "Veo que estás atento. ¿Y ahora?",
		N_EXTRA_VALUES: 3
	},
	4: {
		HINT_KEY: "No sé si lo sabes pero este juego es para una jam con el tema \"De 0 a 100\"\n¿Tienes alguna sospecha de a qué número tenemos que llegar?",
	},
	5: {
		HINT_KEY: "Bueno, pero vayamos poco a poco. ¿Qué tal si te dejo a solas y nos vemos en el 10?",
	}
}


func get_level_config(current_level_index: int):
	current_level_config[HINT_KEY] = null

	if current_level_index in _level_configs:
		if HINT_KEY in _level_configs[current_level_index]:
			current_level_config[HINT_KEY] = _level_configs[current_level_index][HINT_KEY]
		if N_EXTRA_VALUES in _level_configs[current_level_index]:
			current_level_config[N_EXTRA_VALUES] = _level_configs[current_level_index][N_EXTRA_VALUES]

	return current_level_config
