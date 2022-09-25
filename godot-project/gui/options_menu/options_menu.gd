extends Control


const SFX_VOLUME_RANGE = 20
const MUSIC_VOLUME_RANGE = 20


func _ready():
	$center_container/panel/margin_container/vbox_container/sfx_volume_container/hbox_container/slider.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")) + SFX_VOLUME_RANGE) / (SFX_VOLUME_RANGE * 2) * 100
	$center_container/panel/margin_container/vbox_container/music_volume_container/slider.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")) + MUSIC_VOLUME_RANGE) / (MUSIC_VOLUME_RANGE * 2) * 100


func _on_sfx_slider_value_changed(value):
	_on_volume_changed(value, "SFX", SFX_VOLUME_RANGE)


func _on_music_slider_value_changed(value):
	_on_volume_changed(value, "music", MUSIC_VOLUME_RANGE)


func _on_volume_changed(value, bus_name, volume_range):
	var volume = value / 100 * (volume_range * 2) - volume_range
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), volume)
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), volume < -(volume_range - 1))
	


func _on_main_menu_button_pressed():
	get_tree().change_scene("res://gui/main_menu/main_menu.tscn")



