extends Node


const HINT_KEY = "hint"
const N_EXTRA_VALUES = 0
const TRICK = "trick"


var current_level_config = {}
var accumulated_tricks = []

const TrickType = preload("res://globals/trick_type.gd").TrickType

var initial_trick_probability = 40
var trick_probability_increase_per_level = 2
var accumulated_trick_probability = null

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
	},
	11: {
		HINT_KEY: "¡Hola de nuevo! ¿Cómo lo llevas?\nEspero que bien porque tengo malas noticias"
	},
	12: {
		HINT_KEY: "A partir de ahora va a haber distraciones por el camino, ¡pero yo creo en ti!\n¡Pulsa ese 13 y sigamos!"
	},
	13: {
		HINT_KEY: "¡Jajaja! Veo que no es difícil distraerte ;-)"
	},
	14: {
		HINT_KEY: "Pero no nos confiemos, ¿ok?\n¡Bueno, pulsa ese 14 y nos vemos en el 20!"
	},
	17: {
		TRICK: TrickType.HINT_TEXT
	}
}


func _ready():
	current_level_config = {
		HINT_KEY: null,
		N_EXTRA_VALUES: 0,
		TRICK: null
	}


func get_level_config(current_level_index: int):
	current_level_config[HINT_KEY] = null
	current_level_config[TRICK] = null

	if current_level_index in _level_configs:
		if HINT_KEY in _level_configs[current_level_index]:
			current_level_config[HINT_KEY] = _level_configs[current_level_index][HINT_KEY]
		if N_EXTRA_VALUES in _level_configs[current_level_index]:
			current_level_config[N_EXTRA_VALUES] = _level_configs[current_level_index][N_EXTRA_VALUES]

		if TRICK in _level_configs[current_level_index]:
			# The current level adds a new type of trick. Force it for this level and then
			# add it to the list of accumulated tricks to select from for next levels.
			current_level_config[TRICK] = _level_configs[current_level_index][TRICK]
			accumulated_tricks.append(_level_configs[current_level_index][TRICK])
			print("NEW TRICK ", current_level_config[TRICK])
	if not current_level_config[TRICK]:
		var valid_tricks = [] + accumulated_tricks
		if HINT_KEY in current_level_config:
			valid_tricks.erase(TrickType.HINT_TEXT)
		
		if len(valid_tricks):
			print("valid_tricks ", valid_tricks)
			if accumulated_trick_probability:
				accumulated_trick_probability += trick_probability_increase_per_level
			else:
				accumulated_trick_probability = initial_trick_probability
			print("accumulated_trick_probability ", accumulated_trick_probability)
			randomize()
			var random_value = randi() % 100
			print("random_value ", random_value)
			if random_value <= accumulated_trick_probability:
				current_level_config[TRICK] = valid_tricks[randi() % len(valid_tricks)]
				print("RANDOM TRICK ", current_level_config[TRICK])
			else:
				print("NO TRICK")

	return current_level_config
