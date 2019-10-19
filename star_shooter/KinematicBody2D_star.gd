extends KinematicBody2D

var velocity
signal collidedWithBullet

func _process(delta):
	var collision = move_and_collide(velocity)
	if collision:
		if collision.collider.is_in_group("boundaries"):
			get_parent().remove_child(self)
		if collision.collider.is_in_group("bullets"):
			#delete bullet and star and send signal
			emit_signal("collidedWithBullet")
			collision.collider.queue_free()
			get_parent().remove_child(self)
		
