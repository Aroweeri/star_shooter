extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$time.text = str(int(global.time))
	$hits.text = str(int(global.hits))
	$accuracy.text = str(global.accuracy) + "%"
