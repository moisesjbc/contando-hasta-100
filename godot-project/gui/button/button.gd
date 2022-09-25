extends Button


func _on_restart_button_pressed():
	get_node("/root/button_pressed_sound").play()
