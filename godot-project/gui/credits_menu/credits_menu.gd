extends Control




func _on_text_meta_clicked(meta):
	print("META ", meta)
	var error_code = OS.shell_open(meta)
	if error_code != 0:
		print('ERROR opening ' + meta + ' - error code: ' + str(error_code))


func _on_return_to_main_menu_button_pressed():
	get_tree().change_scene("res://gui/main_menu/main_menu.tscn")
