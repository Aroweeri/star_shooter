extends Node2D

func _process(delta):
	var mousePos = get_global_mouse_position()
	look_at(mousePos)
