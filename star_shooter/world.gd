extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	get_node("gun_node/gun").connect("addEnergy", self, "_addEnergy")
	get_node("gun_node/gun").connect("removeEnergy", self, "_removeEnergy")
	$energy.text = str(energy) + "/" + str(maxEnergy) #Initialize energy label text

func _addEnergy():
	hits+=1
	energy+=4
	if(energy > maxEnergy):
		energy = maxEnergy
	
func _removeEnergy():
	energy-=1
	bulletsShot+=1


var starTimer = 0    #When this reaches a certain value, a new star is instanced
var energyTimer = 0  #Used to remove one energy every second
var rng = RandomNumberGenerator.new()
var energy = 20      #default energy amount. When the player runs out the game ends.
var time = 0         #current playtime
var difficulty = 1   #speed multiplier for the star's velocity
var hits = 0         #the number of stars the player has destroyed
var maxEnergy = 40   #the max energy that the player can accumulate
var bulletsShot = 0  #the number of shots the player has taken. Different from hits

func _process(delta):
	$energy.text = str(energy) + "/" + str(maxEnergy)
	$time.text = str(int(time))
	starTimer+=delta
	energyTimer+=delta
	time+=delta
	if(energyTimer >= 1):
		_removeEnergy()
		energyTimer = 0;
	if(energy == 0):
		
		#add game data to global object to pass to game over scene
		global.time = time
		global.hits = hits
		if(hits == 0):
			global.accuracy = 0
		else:
			global.accuracy = stepify(float(hits)/float(bulletsShot)*100, 0.01)
			
		#change scenes
		get_tree().change_scene("res://game_over.tscn")
		var root = get_tree().get_root()
		var level = root.get_node("world")
		root.remove_child(level)
		level.call_deferred("free")
		var nextScene = load("res://game_over.tscn").instance()
		root.add_child(nextScene)
		
	if(starTimer >= 0.3):
		difficulty+=0.01 #increase the difficulty each time a star is made
		starTimer = 0    #reset star timer
		
		#create new star
		var newStarScene = load("res://KinematicBody2D_star.tscn")
		var newStar = newStarScene.instance()
		var randomSide = rng.randi_range(1,4) #pick a side of the stage to generate a star on
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
			
		#angleAdjustment to make sure stars miss the asteroid every time. They can go to the left or right of it
		var angleAdjustment = rng.randf_range(0.25,0.7)
		if rng.randi_range(1,2) == 1: #two sided die
			angleAdjustment *= -1
		newStar.velocity = Vector2(cos(newStar.position.direction_to(Vector2(0,0)).angle() + angleAdjustment), sin(newStar.position.direction_to(Vector2(0,0)).angle() + angleAdjustment))
		newStar.velocity *= rng.randf_range(1,4) + difficulty
		newStar.connect("collidedWithBullet", self, "_addEnergy")
		
		self.add_child(newStar)
