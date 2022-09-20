# Bases

- https://itch.io/jam/indie-spain-jam
- Tema: de 0 a 100
- Subtema: Rejugabilidad: soluciones sitémicas, emergentes o procedurales.

# Ideas

- Cargar móvil. Hacer que llegue al 100% sin que lo eviten XXX.
- Temperatura. Conseguir que el agua se evapore a 100 grados para XXX.
- "RTS" llegar a 100 de población en un entorno hostil (¿fantasmas asustando gente para matarla versus Cazafantasmas?)
    - O 100 en la época medieval con catástrofes y tal
    - ¿Cuál es el 0?
- Llegar a 100 metros de altura
- Llegar a 100 seeders en Emule
- Reunir 100 monedas del sillón.
- Juntar 100 matches en Tinder que no sean bots o desaparezcan
- Células de 0 a 100

## División celular

### Resumen

Juego por turnos en el que dos jugadores compiten para ser el primero en generar 100 células a base de añadir células y dividir las existentes.

### Mecánicas

- Juego por turnos.
- Jugador vs jugador o jugador vs IA.
- En el primer turno cada jugador recibe al menos una carta / acción de crear célula y tres cartas aleatorias.
- En turnos siguientes el jugador recibe una carta de división si tiene al menos una célula o una de crear célula y tres cartas aleatorias.
- Las cartas / acciones se juegan sobre un área y afectan a todas las células propias o enemigas según la acción.
- Acciones
    - Crear célula: se elige cualquier sitio **vacío** del mapa y se crea ahí.
    - División: se elige una célula y se elige el sitio hacia el que se divide. Una nueva célula aparece y ambas hijas tienen la mitad de poder / energía que el padre.
        - Puede haber variantes donde la célula se divide en más partes, o las partes conservan la misma energía que el padre, etc.
    - Aumento de energía: se elige una célula y se aumenta su energía en X.
    - Disminución de energía: se elige una célula y se aumenta su energía en X.
    - Movimiento: se elige una célula (¿o grupo?) y una dirección (¿colisiones?).
- Cuando una célula choca con una célula enemiga se restan sus energías. La que menos tiene desaparece y la otra disminuye su energía.
- Zonas de crecimiento que dan +1 o divide células cada turno (¿Hacia dónde sin que colisionen?) Aparecen aleatoriamente sobre el centro del mapa para forzar a ir hacia allí

# Problemáticas / por decidir

- ¿Tamaño del mapa?
- ¿Alguna condición de que las células deben estar cerca unas de otras para vivir?
- ¿Las células no deberían colisionar entre ellas de alguna manera?
    - ¿Si las nuevas células chocan con otra propia se unen a esta?
    - O puedo hacer que sólo uno de los hijos se mueva de sitio y no puedas hacerlo si no hay espacio / no se va a unir a otra célula.
- Previsualizar resultado **inmediato** de acción al clicar y doble clic para confirmar (para mantener mismo comportamiento en móvil y PC).
- ¿Cómo hago que sea entretenido jugar contra IA o entorno sin volverme loco?
- ¿Qué hago con los bordes de la pantalla? ¿Las células chocan con él y rebotan? ¿Y si dos hijos vuelven a chocarse entre sí al rebotar uno o ambos contra la pared?

## Contar de 0 a 100

Aparece un conjunto de pelotas en la pantalla. El jugador debe ir clicando en los números de 0 a 100. Al final obtendrá una puntuación basada en rapidez, combos, etc.

### Mecánicas

- Aparecen pelotas aleatorias, unas con números y otras con operaciones (pe. x2, +1, -1, etc)
- Si el usuario clica en una pelota con un número:
    - Si es el número siguiente: el número explota y el jugador debe buscar el siguiente número. Se añaden puntos a su puntuación.
    - Si no es el número siguiente: el número explota y el jugador ¿pierde?
- Si el usuario clica en una pelota con una operación:
    - Si a continuación clica en una pelota con un número le aplica la operación recurrentemente: cada segundo se aplicará la operación.
    - ¿Si clica en otra operación se le aplica al número de la operación (pe. +1 a x2 -> x3)?
    - ¿Y si clica en un número que ya tiene una operación?
