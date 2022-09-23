extends Panel

var main


func display(main, current_value):
	get_tree().paused = true
	visible = true
	self.main = main
	if main.is_victory():
		$margin_container/vbox_container/title.text = "¡VICTORIA!"
	else:
		$margin_container/vbox_container/title.text = "Game over"
	
	$margin_container/vbox_container/description.text = "¡Has llegado al %d!" % current_value


func _on_restart_button_pressed():
	get_tree().paused = false
	visible = false
	main.set_level(0)
