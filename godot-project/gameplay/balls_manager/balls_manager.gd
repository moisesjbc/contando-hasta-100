extends Node

signal number_selected

var right_value = 0
var numeric_ball_scene = preload("res://gameplay/balls/numeric_ball/numeric_ball.tscn")

func set_level(new_right_value: int):
	right_value = new_right_value
	reset()


func reset():
	var SRC_X = 200
	var DST_X = 1080
	
	randomize()
	
	for ball in $balls.get_children():
		$balls.remove_child(ball)
		ball.queue_free()

	for i in range(right_value - 3, right_value + 3):
		var numeric_ball = numeric_ball_scene.instance()
		numeric_ball.global_position = _get_random_respawn_position()
		$balls.add_child(numeric_ball)
		numeric_ball.set_value(i)
		numeric_ball.connect("numeric_ball_selected", self, "_on_numeric_ball_selected")


func _get_random_respawn_position():
	return Vector2(
		$respawn_region/top_left_corner.global_position.x + randi() % int($respawn_region/bottom_right_coner.global_position.x - $respawn_region/top_left_corner.global_position.x),
		$respawn_region/top_left_corner.global_position.y + randi() % int($respawn_region/bottom_right_coner.global_position.y - $respawn_region/top_left_corner.global_position.y)
	)

func _ready():
	reset()

func _on_numeric_ball_selected(selected_ball):
	emit_signal("number_selected", selected_ball.value)
