extends Node


enum LevelConfigKey {
	HINT,
	N_EXTRA_VALUES,
	TRICK,
	GAME_OVER_TAUNT,
	GAME_OVER_TAUNT_VALUE
}


var current_level_config = {}
var accumulated_tricks = []

const TrickType = preload("res://globals/trick_type.gd").TrickType

var initial_trick_probability = 40
var trick_probability_increase_per_level = 2
var accumulated_trick_probability = null

var _level_configs = {
	0: {
		LevelConfigKey.HINT: "¡Oh! ¡Hola!\n¿Podrías hacerme un favor y presionar sobre ese 0 de ahí abajo?",
	},
	1: {
		LevelConfigKey.HINT: "¡Guay, gracias!\n¿Y qué tal con el 1?"
	},
	2: {
		LevelConfigKey.HINT: "¡Perfecto!\n¿Ahora podrías darle al 2?",
		LevelConfigKey.N_EXTRA_VALUES: 2,
	},
	3: {
		LevelConfigKey.HINT: "0, 1, 2..., ¿adivinas cuál vendría ahora?",
		LevelConfigKey.GAME_OVER_TAUNT: "No pasa nada. No todo el mundo domina eso de contar"
	},
	4: {
		LevelConfigKey.HINT: "¡Eres la caña! Sigamos con el... con el...\n ¡Vaya!, me he olvidado, ¿cuál seguía ahora?",
	},
	5: {
		LevelConfigKey.HINT: "Veo que estás atento. ¿Y ahora?",
		LevelConfigKey.N_EXTRA_VALUES: 3
	},
	6: {
		LevelConfigKey.HINT: "No sé si lo sabes pero este juego gira en torno al tema \"De 0 a 100\"\n¿Tienes alguna sospecha de a qué número tenemos que llegar?",
	},
	7: {
		LevelConfigKey.HINT: "Imagino que lo sospechas, pero vayamos poco a poco.\n¿Qué tal si te dejo un momentito a solas y nos vemos en el 10?",
		LevelConfigKey.GAME_OVER_TAUNT: "No puedo estar siempre contigo. Tienes que abandonar el nido."
	},
	11: {
		LevelConfigKey.HINT: "¡Hola de nuevo! ¿Cómo lo llevas?\nEspero que bien porque tengo malas noticias",
		LevelConfigKey.GAME_OVER_TAUNT: "¡Pero al menos espera a las malas noticias!"
	},
	12: {
		LevelConfigKey.HINT: "A partir de ahora va a haber distraciones por el camino, así que no te fies de nada ni de NADIE\n¡Bueno, pulsa ese 13 y sigamos!",
		LevelConfigKey.GAME_OVER_TAUNT: "¡Pero bueno, si te acabo de decir que no te fies de NADIE! ;-)",
		LevelConfigKey.GAME_OVER_TAUNT_VALUE: 13
	},
	13: {
		LevelConfigKey.HINT: "¡Jajaja! Veo que no es fácil distraerte ;-)"
	},
	14: {
		LevelConfigKey.HINT: "Pero no nos confiemos, ¿ok?\n¡Bueno, pulsa ese 14 y nos vemos en el 20!"
	},
	17: {
		LevelConfigKey.TRICK: TrickType.HINT_TEXT
	},
	21: {
		LevelConfigKey.HINT: "Un quinto del camino, ¿eh?. ¡No está nada mal!\nA POR EL 20",
		LevelConfigKey.GAME_OVER_TAUNT: "Ah, ¿el 20 ya lo habías pulsado? Culpa mía ^^U",
		LevelConfigKey.GAME_OVER_TAUNT_VALUE: 20
	},
	22: {
		LevelConfigKey.HINT: "¡Tienes razón! ¡Era el 21! :-D"
	},
	25: {
		LevelConfigKey.HINT: "Ignora el fondo. Godot me lo cambia a veces.",
		LevelConfigKey.TRICK: TrickType.BACKGROUND_NUMBER,
		LevelConfigKey.GAME_OVER_TAUNT: "Ya sabía yo que ese fondo era una mala influencia"
	},
	35: {
		LevelConfigKey.HINT: "¡QUE SE ESCAPA!",
		LevelConfigKey.TRICK: TrickType.MOVING_BALL,
		LevelConfigKey.GAME_OVER_TAUNT: "Vaya movida. Jajaja, ¿lo pillas? MOVIda por la bola que se MOVIa.\nVale, ha sido malo, pero al menos yo no he perdido la cuenta, ¿no?"
	},
	45: {
		LevelConfigKey.HINT: "¡Ah! Eso no será la cuenta atrás de una bomba, ¿verdad? ¿VERDAD?",
		LevelConfigKey.TRICK: TrickType.TIME_BAR,
		LevelConfigKey.GAME_OVER_TAUNT: "A lo mejor no era una bomba, no."
	},
	46: {
		LevelConfigKey.HINT: "¡Uff! Parece que no lo era"
	},
	51: {
		LevelConfigKey.HINT: "¡Mitad del camino! ¡Dale al 50 para continuar!",
		LevelConfigKey.GAME_OVER_TAUNT: "¿O era el 51?",
		LevelConfigKey.GAME_OVER_TAUNT_VALUE: 50
	},
	55: {
		LevelConfigKey.TRICK: TrickType.NOTIFICATION,
		LevelConfigKey.GAME_OVER_TAUNT: "Mira que me salio fea la notificación y aún así caíste :-D"
	},
	65: {
		LevelConfigKey.TRICK: TrickType.POPUP,
		LevelConfigKey.GAME_OVER_TAUNT: "Así que los popups son tu debilidad, ¿eh?"
	},
	75: {
		LevelConfigKey.TRICK: TrickType.HIGHLIGHT_BALL,
		LevelConfigKey.GAME_OVER_TAUNT: "Parece que el tamaño importa después de todo"
	},
	85: {
		LevelConfigKey.TRICK: TrickType.BLINKING_BALLS,
		LevelConfigKey.GAME_OVER_TAUNT: "¡Si parapadeas te lo pierdes! :-D"
	}
}


func get_level_config(current_level_index: int):
	if current_level_index == 0:
		accumulated_tricks = []
		current_level_config = {
			LevelConfigKey.HINT: null,
			LevelConfigKey.N_EXTRA_VALUES: 0,
			LevelConfigKey.TRICK: null
		}
	
	current_level_config[LevelConfigKey.HINT] = null
	current_level_config[LevelConfigKey.TRICK] = null
	current_level_config[LevelConfigKey.GAME_OVER_TAUNT] = null
	current_level_config[LevelConfigKey.GAME_OVER_TAUNT_VALUE] = null

	if current_level_index in _level_configs:
		for level_config_key in [LevelConfigKey.HINT, LevelConfigKey.N_EXTRA_VALUES, LevelConfigKey.GAME_OVER_TAUNT, LevelConfigKey.GAME_OVER_TAUNT_VALUE]:
			if level_config_key in _level_configs[current_level_index]:
				current_level_config[level_config_key] = _level_configs[current_level_index][level_config_key]

		if LevelConfigKey.TRICK in _level_configs[current_level_index]:
			# The current level adds a new type of trick. Force it for this level and then
			# add it to the list of accumulated tricks to select from for next levels.
			current_level_config[LevelConfigKey.TRICK] = _level_configs[current_level_index][LevelConfigKey.TRICK]
			accumulated_tricks.append(_level_configs[current_level_index][LevelConfigKey.TRICK])
			print("NEW LevelConfigKey.TRICK ", current_level_config[LevelConfigKey.TRICK])
	if not current_level_config[LevelConfigKey.TRICK]:
		var valid_tricks = [] + accumulated_tricks
		if current_level_config[LevelConfigKey.HINT] != null:
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
				current_level_config[LevelConfigKey.TRICK] = valid_tricks[randi() % len(valid_tricks)]
				print("RANDOM LevelConfigKey.TRICK ", current_level_config[LevelConfigKey.TRICK])
			else:
				print("NO LevelConfigKey.TRICK")

	return current_level_config
