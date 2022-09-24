extends Panel


func set_hint(hint):
	if hint:
		visible = true
		$hint_label.text = hint
	else:
		visible = false
