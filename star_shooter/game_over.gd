extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$time.text = str(int(global.time))
	$hits.text = str(int(global.hits))
	$accuracy.text = str(global.accuracy) + "%"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
