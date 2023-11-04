class_name Gun extends Node2D

@export var bullet_scene: PackedScene

var scale_degree = 30

func _physics_process(_delta):
	orbit_around_parent()

func orbit_around_parent():
	var mouse_position: Vector2 = get_global_mouse_position()
	# Get the vector between the player and the mouse position and normalize it
	var direction: Vector2 = (mouse_position - get_parent().position).normalized() * scale_degree
	self.position = direction

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = self.global_position
	bullet.direction = (get_global_mouse_position() - self.global_position).normalized()
	get_parent().call_deferred("add_sibling", bullet)
	
