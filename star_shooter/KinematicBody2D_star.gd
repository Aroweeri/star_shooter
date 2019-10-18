extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var velocity

signal collidedWithBullet

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	var collision = move_and_collide(velocity)
	if collision:
		if collision.collider.is_in_group("boundaries"):
			get_parent().remove_child(self)
		if collision.collider.is_in_group("bullets"):
			emit_signal("collidedWithBullet")
			collision.collider.queue_free()
			get_parent().remove_child(self)
		
