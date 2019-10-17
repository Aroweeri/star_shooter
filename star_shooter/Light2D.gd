extends Light2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var starRotation

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	starRotation = rng.randf_range(-0.10, 0.10)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	rotate(starRotation)
