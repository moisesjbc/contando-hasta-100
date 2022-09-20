extends Area2D


var number = 1


func _ready():
	$label.bbcode_text = "[center]" + str(number) + "[/center]"
