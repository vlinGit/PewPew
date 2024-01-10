extends Area2D

var speed = 750.0
signal hit 

func _process(delta):
	position += (transform.x * speed * delta)

func _on_body_entered(body):
	if body.is_in_group("mobs"):
		emit_signal("hit")
		body.queue_free()
		queue_free()

func _on_bullet_timeout_timeout():
	queue_free()
