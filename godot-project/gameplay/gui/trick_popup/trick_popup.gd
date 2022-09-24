extends Control


var texts = [
	"¿Sigues ahí?",
	"¿Cuántas patas tiene un caballo empadronado en Alfa Centauri?",
	"¿Cuántos kilos pesa un rinocerone subacuático?",
	"¿Cuántos años cotiza el cangrejo imperial antes de jubilarse?"
]


func set_active(active: bool, v0: int, v1: int, v2: int, v3: int):
	visible = active
	if active:
		randomize()
		$center_container/panel/margin_container/vbox_container/label.text = texts[randi() % len(texts)]
		$center_container/panel/margin_container/vbox_container/hbox_container/left_button.text = str(v0)
		$center_container/panel/margin_container/vbox_container/hbox_container/right_button.text = str(v1)
		$center_container/panel/margin_container/vbox_container/hbox_container_2/left_button.text = str(v2)
		$center_container/panel/margin_container/vbox_container/hbox_container_2/right_button.text = str(v3)


func _on_button_pressed():
	set_active(false, 0, 0, 0, 0)
