extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _pressed():
	var root = get_tree().get_root()
	var level = root.get_node("Control")
	root.remove_child(level)
	level.call_deferred("free")
	var nextScene = load("res://Node2D.tscn").instance()
	root.add_child(nextScene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
