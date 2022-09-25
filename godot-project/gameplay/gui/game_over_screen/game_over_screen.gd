extends CenterContainer

var main


func display(new_main, selected_value, expected_value, taunt):
	get_tree().paused = true
	visible = true
	main = new_main
	
	$panel/margin_container/vbox_container/taunt.visible = (taunt != null) or (selected_value == expected_value)
		
	if selected_value == expected_value:
		$panel/margin_container/vbox_container/title.text = "¡VICTORIA!"
		$panel/margin_container/vbox_container/summary.text = "¡Gracias por jugar!"
		$panel/margin_container/vbox_container/taunt.text = "Me arrodillo ante tu capacidad de concentración.\nNo da para dedicarte una peli pero por algo se empieza."
	else:
		$panel/margin_container/vbox_container/title.text = "Game over"
		$panel/margin_container/vbox_container/summary.text = "Has seleccionado el {selected_value} pero tocaba el {expected_value}".format({
			"selected_value": selected_value,
			"expected_value": expected_value
		})
		if taunt:
			$panel/margin_container/vbox_container/taunt.text = taunt
		
		


func _on_restart_button_pressed():
	get_tree().paused = false
	visible = false
	main.set_level(main.first_level)
