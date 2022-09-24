extends MarginContainer


func set_hint(hint):
	if hint:
		visible = true
		$panel/hint_label.text = hint
	else:
		visible = false
