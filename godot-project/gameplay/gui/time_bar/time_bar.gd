extends HSlider


signal timeout


var total_time_in_seconds = null
var current_time_in_seconds = null


func _ready():
	set_time(15)


func set_time(new_total_time_in_seconds):
	total_time_in_seconds = new_total_time_in_seconds
	reset()
	

func reset():
	current_time_in_seconds = total_time_in_seconds


func _update_value():
	value = current_time_in_seconds / total_time_in_seconds * 100.0
	

func _process(delta):
	if total_time_in_seconds != null:
		current_time_in_seconds = current_time_in_seconds - delta
		_update_value()
		if current_time_in_seconds < 0.01:
			emit_signal("timeout")
