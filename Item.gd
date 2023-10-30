class_name Item extends Node2D

@export var resource: ItemResource

@onready var pickup_area: Area2D = $Area2D

func _ready():
	if resource:
		print_debug(resource.type)
		print_debug(resource.stats)
		print_debug(resource.potion_sub_type)
		# pickup_area.body_entered.connect(_trigger_pickup)
	else:
		print_debug("Error: resource not set")
		self.queue_free()
	

# func _trigger_pickup(body: Node2D):
# 	if body is Player:
# 		print_debug(body)
