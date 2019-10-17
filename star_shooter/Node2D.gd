extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var starTimer = 0
var rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	starTimer+=delta
	if(starTimer >= 1000):
		print("hi")
		starTimer = 0
		var newStarScene = load("res://KinematicBody2D_star.tscn")
		var newStar = newStarScene.instance()
		newStar.position = Vector2(rng.randi_range(-500,500), rng.randi_range(-400,400))
		self.add_child(newStar)
