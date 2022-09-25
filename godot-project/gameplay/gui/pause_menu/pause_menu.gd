extends Control


func set_paused(paused: bool):
	get_tree().paused = paused
	$center_container.visible = paused


func _on_resume_game_button_pressed():
	set_paused(false)


func _on_return_to_main_menu_button_pressed():
	set_paused(false)
	get_tree().change_scene("res://gui/main_menu/main_menu.tscn")
	

func _input(event):
	if not get_tree().paused and event is InputEventKey and event.scancode == KEY_ESCAPE:
		set_paused(true) 


func _on_pause_button_pressed():
	set_paused(true)
