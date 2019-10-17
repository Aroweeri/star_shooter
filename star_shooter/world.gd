extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

var starTimer = 0
var rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	starTimer+=delta
	if(starTimer >= 1):
		starTimer = 0
		var newStarScene = load("res://KinematicBody2D_star.tscn")
		var newStar = newStarScene.instance()
		var randomSide = rng.randi_range(1,4)
		var topAreaX = rng.randi_range(get_node("Position2D_top_1").position.x, get_node("Position2D_top_2").position.x)
		var topAreaY = rng.randi_range(get_node("Position2D_top_1").position.y, get_node("Position2D_top_2").position.y)
		var rightAreaX = rng.randi_range(get_node("Position2D_right_1").position.x, get_node("Position2D_right_2").position.x)
		var rightAreaY = rng.randi_range(get_node("Position2D_right_1").position.y, get_node("Position2D_right_2").position.y)
		var bottomAreaX = rng.randi_range(get_node("Position2D_bottom_1").position.x, get_node("Position2D_bottom_2").position.x)
		var bottomAreaY = rng.randi_range(get_node("Position2D_bottom_1").position.y, get_node("Position2D_bottom_2").position.y)
		var leftAreaX = rng.randi_range(get_node("Position2D_left_1").position.x, get_node("Position2D_left_2").position.x)
		var leftAreaY = rng.randi_range(get_node("Position2D_left_1").position.y, get_node("Position2D_left_2").position.y)
		if randomSide == 1:
			newStar.position = Vector2(topAreaX, topAreaY)
		elif randomSide == 2:
			newStar.position = Vector2(rightAreaX, rightAreaY)
		elif randomSide == 3:
			newStar.position = Vector2(bottomAreaX, bottomAreaY)
		elif randomSide == 4:
			newStar.position = Vector2(leftAreaX, leftAreaY)
		newStar.velocity = Vector2(rng.randf_range(-10,10), rng.randf_range(-10,10))
		self.add_child(newStar)
