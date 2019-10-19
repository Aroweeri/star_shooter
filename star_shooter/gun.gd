extends Sprite

signal addEnergy
signal removeEnergy

func _starDestroyed():
	emit_signal("addEnergy")

#create a bullet on mouse click
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var bulletscene = load("res://KinematicBody2D_bullet.tscn")
			var bullet = bulletscene.instance()
			bullet.rotation = global_rotation
			bullet.position = get_parent().get_node("muzzle").position.rotated(get_parent().get_node("muzzle").global_rotation)
			bullet.set_velocity(Vector2(7,0).rotated(global_rotation))
			bullet.connect("starDestroyed", self, "_starDestroyed")
			emit_signal("removeEnergy")
			get_node("/root/world").add_child(bullet)
