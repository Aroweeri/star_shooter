extends KinematicBody2D

var velocity = Vector2()
signal starDestroyed

func set_velocity(_velocity):
	velocity = _velocity

func _process(delta):
	var collision = move_and_collide(velocity)
	if collision:
		if collision.collider.is_in_group("stars"):
			get_parent().remove_child(self)
			collision.collider.queue_free()
			emit_signal("starDestroyed")
		if collision.collider.is_in_group("boundaries"):
			get_parent().remove_child(self)
