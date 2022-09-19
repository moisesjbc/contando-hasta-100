extends KinematicBody2D


var cell_scene = load("res://gameplay/cell/cell.tscn")

func _ready():
	set_pickable(true)

func divide():
	var new_cell = cell_scene.instance()
	get_parent().add_child(new_cell)
	new_cell.global_position = global_position + Vector2(75.0, 0.0)


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and event.pressed:
		divide()
