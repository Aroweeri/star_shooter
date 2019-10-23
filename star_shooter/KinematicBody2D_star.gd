extends KinematicBody2D

var velocity
var starRotation
signal collidedWithBullet

func _ready():
	starRotation = global.rng.randf_range(-0.10, 0.10)

func _process(delta):
	rotate(starRotation)
	var collision = move_and_collide(velocity)
	if collision:
		if collision.collider.is_in_group("boundaries"):
			get_parent().remove_child(self)
		if collision.collider.is_in_group("bullets"):
			#delete bullet and star and send signal
			emit_signal("collidedWithBullet")
			collision.collider.queue_free()
			get_parent().remove_child(self)
		
