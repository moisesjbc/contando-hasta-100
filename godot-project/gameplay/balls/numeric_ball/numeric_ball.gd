extends Area2D


var number = 0


func _ready():
	$label.bbcode_text = "[center]" + str(number) + "[/center]"
