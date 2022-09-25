extends Control


func _ready():
	$center_container/panel/margin_container/vbox_container/exit_game_button.visible = (OS.get_name() != "HTML5")


func _on_start_game_button_pressed():
	get_tree().change_scene("res://gameplay/main/main.tscn")


func _on_exit_game_button_pressed():
	get_tree().quit()
