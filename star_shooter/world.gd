extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.
	get_node("gun_node/gun").connect("addEnergy", self, "_addEnergy")
	get_node("gun_node/gun").connect("removeEnergy", self, "_removeEnergy")
	$energy.text = str(energy) + "/" + str(maxEnergy)
	
func _addEnergy():
	hits+=1
	energy+=4
	if(energy > maxEnergy):
		energy = maxEnergy
	
func _removeEnergy():
	energy-=1
	bulletsShot+=1

var starTimer = 0
var energyTimer = 0
var rng = RandomNumberGenerator.new()
var energy = 20
var time = 0
var difficulty = 1
var hits = 0
var maxEnergy = 40
var bulletsShot = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	$energy.text = str(energy) + "/" + str(maxEnergy)
	$time.text = str(int(time))
	starTimer+=delta
	energyTimer+=delta
	time+=delta
	if(energyTimer >= 1):
		energy-=1
		energyTimer = 0;
	if(energy == 0):
		global.time = time
		global.hits = hits
		global.accuracy = stepify(float(hits)/float(bulletsShot)*100, 0.01)
		get_tree().change_scene("res://game_over.tscn")
		var root = get_tree().get_root()
		var level = root.get_node("world")
		root.remove_child(level)
		level.call_deferred("free")
		var nextScene = load("res://game_over.tscn").instance()
		root.add_child(nextScene)
		
	if(starTimer >= 0.3):
		difficulty+=0.01
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
		var angleAdjustment = rng.randf_range(0.25,0.7)
		if rng.randi_range(1,2) == 1:
			angleAdjustment *= -1
		newStar.velocity = Vector2(cos(newStar.position.direction_to(self.position).angle() + angleAdjustment), sin(newStar.position.direction_to(self.position).angle() + angleAdjustment))
		newStar.velocity *= rng.randf_range(1,4) + difficulty
		newStar.connect("collidedWithBullet", self, "_addEnergy")
		
		self.add_child(newStar)
