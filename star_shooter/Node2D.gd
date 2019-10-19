extends Node2D

var starTimer = 0
var rng = RandomNumberGenerator.new()

func _process(delta):
	starTimer+=delta
	if(starTimer >= 1000):
		print("hi")
		starTimer = 0
		var newStarScene = load("res://KinematicBody2D_star.tscn")
		var newStar = newStarScene.instance()
		newStar.position = Vector2(rng.randi_range(-500,500), rng.randi_range(-400,400))
		self.add_child(newStar)
