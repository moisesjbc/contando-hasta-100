extends Area2D


signal numeric_ball_selected

var value = null
var expected_value = null


func set_value(new_value: int, new_expected_value: int):
	value = new_value
	expected_value = new_expected_value
	$sprite/label.bbcode_text = "[center]" + str(value) + "[/center]"


func _on_numeric_ball_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if value == expected_value:
			$animation_player.play("right_selection")
		else:
			$animation_player.play("wrong_selection")


func _on_animation_player_animation_finished(_anim_name):
	emit_signal("numeric_ball_selected", self)


func move():
	$ball_movement.move()


func attenuate():
	scale = Vector2(0.75, 0.75)
	$sprite.modulate = Color.orange

func highlight():
	scale = Vector2(1.50, 1.50)
	$sprite.modulate = Color.green
