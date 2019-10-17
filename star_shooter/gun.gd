extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var bulletscene = load("res://KinematicBody2D_bullet.tscn")
			var bullet = bulletscene.instance()
			bullet.get_node("bullet").look_at(get_global_mouse_position())
			#bullet.position = get_node("/root/world/gun_node/Position2D").position
			get_node("/root/world").add_child(bullet)
			print("hi")