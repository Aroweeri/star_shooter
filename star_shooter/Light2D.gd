extends Light2D

var starRotation

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	starRotation = rng.randf_range(-0.10, 0.10)
	pass # Replace with function body.

func _process(delta):
	rotate(starRotation)
