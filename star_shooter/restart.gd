extends Button

func _pressed():
	var root = get_tree().get_root()
	var level = root.get_node("Control")
	root.remove_child(level)
	level.call_deferred("free")
	var nextScene = load("res://Node2D.tscn").instance()
	root.add_child(nextScene)
