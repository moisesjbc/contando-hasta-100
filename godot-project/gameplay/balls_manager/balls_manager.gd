extends Node

signal number_selected

var right_value = 0
var numeric_ball_scene = preload("res://gameplay/balls/numeric_ball/numeric_ball.tscn")

func set_level(new_right_value: int):
	right_value = new_right_value
	reset()
	
var all_respawn_positions = []
var free_respawn_positions = []

func _ready():
	var N_HORIZONTAL_DIVISIONS = 5
	var N_VERTICAL_DIVISIONS = 3
	
	var horizontal_offset = int($respawn_region/bottom_right_coner.global_position.x - $respawn_region/top_left_corner.global_position.x) / N_HORIZONTAL_DIVISIONS
	var vertical_offset = int($respawn_region/bottom_right_coner.global_position.y - $respawn_region/top_left_corner.global_position.y) / N_VERTICAL_DIVISIONS
	
	for vertical_index in range(0, N_VERTICAL_DIVISIONS):
		for horizontal_index in range(0, N_HORIZONTAL_DIVISIONS):
			all_respawn_positions.append(Vector2(
				$respawn_region/top_left_corner.global_position.x + horizontal_index * horizontal_offset,
				$respawn_region/top_left_corner.global_position.y + vertical_index * vertical_offset
			))

	reset()


func reset():
	free_respawn_positions = [] + all_respawn_positions
	
	for ball in $balls.get_children():
		$balls.remove_child(ball)
		ball.queue_free()

	for i in range(right_value - 3, right_value + 3):
		var numeric_ball = numeric_ball_scene.instance()
		numeric_ball.global_position = _get_random_respawn_position()
		$balls.add_child(numeric_ball)
		numeric_ball.set_value(i, right_value)
		numeric_ball.connect("numeric_ball_selected", self, "_on_numeric_ball_selected")


func _get_random_respawn_position():
	randomize()

	var respawn_position_index = randi() % len(free_respawn_positions)
	var respawn_position = free_respawn_positions[respawn_position_index]
	free_respawn_positions.remove(respawn_position_index)
	
	var random_offset = 15
	
	return Vector2(
		respawn_position.x -random_offset + randi() % (random_offset * 2),
		respawn_position.y -random_offset + randi() % (random_offset * 2)
	)

func _on_numeric_ball_selected(selected_ball):
	emit_signal("number_selected", selected_ball.value)
