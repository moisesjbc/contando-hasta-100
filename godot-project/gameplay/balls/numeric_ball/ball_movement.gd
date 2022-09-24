extends Node

var moving: bool = false
var ball = null
var velocity: Vector2 = Vector2.ZERO
var speed: int = 100

func _ready():
	ball = get_parent()

func move():
	moving = true

	if ball.global_position.x > 500:
		velocity.x -= 1
	else:
		velocity.x += 1

	if ball.global_position.y > 350:
		velocity.y -= 1
	else:
		velocity.y += 1


func _process(delta):
	if moving:
		ball.translate(velocity * speed * delta)


func _on_visibility_notifier_screen_exited():
	ball.queue_free()
