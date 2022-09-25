extends Control


const SFX_VOLUME_RANGE = 20


func _ready():
	$center_container/panel/margin_container/vbox_container/sfx_volume_container/hbox_container/slider.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")) + SFX_VOLUME_RANGE) / (SFX_VOLUME_RANGE * 2) * 100


func _on_sfx_slider_value_changed(value):
	var volume = value / 100 * (SFX_VOLUME_RANGE * 2) - SFX_VOLUME_RANGE
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), volume)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), volume < -19)


func _on_main_menu_button_pressed():
	get_tree().change_scene("res://gui/main_menu/main_menu.tscn")
