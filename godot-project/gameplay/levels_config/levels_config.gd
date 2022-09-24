extends Node

const HINT_KEY = "hint"


var level_hints = {
	0: "¡Oh! ¡Hola!\n¿Podrías hacerme un favor y clicar en ese 0 de ahí abajo?",
	1: "¡Guay, gracias!\n¿Y qué tal con el 1?"
}


var current_level_config = {
	HINT_KEY: null
}


func get_level_config(current_level_index: int):
	current_level_config[HINT_KEY] = null
	if current_level_index in level_hints:
		current_level_config[HINT_KEY] = level_hints[current_level_index]

	return current_level_config
