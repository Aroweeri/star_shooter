extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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