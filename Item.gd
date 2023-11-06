class_name Item extends Node2D

@export var resource: ItemResource

@onready var pickup_area: Area2D = $Area2D

func _ready():
	if resource:
		if resource.texture:
			$ItemBlockout.texture = resource.texture
		pass
	else:
		print_debug("Error: resource not set")
		self.queue_free()

