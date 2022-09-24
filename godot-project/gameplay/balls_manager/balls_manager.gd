extends Node

signal number_selected

var right_value = 0
var n_extra_values = 0
var trick_type = null
var numeric_ball_scene = preload("res://gameplay/balls/numeric_ball/numeric_ball.tscn")
var TrickType = preload("res://globals/trick_type.gd").TrickType

func set_level(new_right_value: int, new_n_extra_values: int, new_trick_type):
	right_value = new_right_value
	n_extra_values = new_n_extra_values
	trick_type = new_trick_type
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


func _instantiate_numeric_ball(value: int, right_value: int):
	var numeric_ball = numeric_ball_scene.instance()
	numeric_ball.global_position = _get_random_respawn_position()
	$balls.add_child(numeric_ball)
	numeric_ball.set_value(value, right_value)
	numeric_ball.connect("numeric_ball_selected", self, "_on_numeric_ball_selected")

func reset():
	free_respawn_positions = [] + all_respawn_positions
	
	for ball in $balls.get_children():
		$balls.remove_child(ball)
		ball.queue_free()

	for i in range(right_value - n_extra_values, right_value):
		_instantiate_numeric_ball(i, right_value)
		
	_instantiate_numeric_ball(right_value, right_value)
	
	for i in range(right_value + 1, right_value + n_extra_values):
		_instantiate_numeric_ball(i, right_value)
		
	if trick_type == TrickType.MOVING_BALL:
		randomize()
		var ball_index = randi() % $balls.get_child_count()
		$balls.get_child(ball_index).move()


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
