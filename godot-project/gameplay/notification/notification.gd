extends Node2D


var notification_messages = [
	"¡No pulses el %d!",
	"¡Pulsa el %d para salvarnos a todos!",
	"Por lo que más quieras, ¡no pulses el %d!"
]


func _ready():
	set_active(false, 0)


func set_active(active: bool, value: int):
	visible = active
	$notification_background/animation_player.stop()
	if active:
		$notification_background/animation_player.play("appearance")
		$notification_background/label.text = "¡IMPORTANTE!\n" + notification_messages[randi() % len(notification_messages)] % value
		$notification_sound.play()
