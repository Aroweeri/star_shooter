extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

signal addEnergy
signal removeEnergy

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _starDestroyed():
	emit_signal("addEnergy")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var bulletscene = load("res://KinematicBody2D_bullet.tscn")
			var bullet = bulletscene.instance()
			bullet.rotation = global_rotation
			bullet.position = get_parent().get_node("muzzle").global_position
			bullet.set_velocity(Vector2(7,0).rotated(global_rotation))
			bullet.connect("starDestroyed", self, "_starDestroyed")
			emit_signal("removeEnergy")
			get_node("/root/world").add_child(bullet)