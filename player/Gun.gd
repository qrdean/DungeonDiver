class_name Gun extends Node2D

var scale_degree = 30

func _physics_process(delta):
	var mouse_position: Vector2 = get_global_mouse_position()
	# Get the vector between the player and the mouse position and normalize it
	var direction: Vector2 = (mouse_position - get_parent().position).normalized() * scale_degree
	self.position = direction
