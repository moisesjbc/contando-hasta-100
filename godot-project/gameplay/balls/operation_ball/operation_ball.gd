extends Area2D


var expression_label = "x2"
var expression_str = "2 * x"
var expression = Expression.new()


func _ready():
	$label.bbcode_text = "[center]" + expression_label + "[/center]"
