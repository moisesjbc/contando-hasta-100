extends Node

var ball = null
var animation_player = null
var current_animation = "disappear"

func activate(new_ball, new_animation_player):
	ball = new_ball
	animation_player = new_animation_player
	play_animation()


func play_animation():
	animation_player.play(current_animation)
	if current_animation == "appear":
		current_animation = "disappear"
	else:
		current_animation = "appear"
	start_timer()


func start_timer():
	randomize()
	$timer.start(2.0 + randf() * 4.0)


func _on_timer_timeout():
	play_animation()
