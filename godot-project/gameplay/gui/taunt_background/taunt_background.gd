extends Control


func clear():
	for child in $center_container.get_children():
		child.visible = false


func repeat_number(number):
	$center_container/small_text.visible = true
	$center_container/small_text.text = ("%d - " % number).repeat(500)
