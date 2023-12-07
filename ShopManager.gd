class_name ShopManager extends Node2D

@onready var shop_node: Shop = $Shop

# Called when the node enters the scene tree for the first time.
func _ready():

	if get_parent() != null and get_parent().level_data != null:
		var level_data: LevelData = get_parent().level_data 
		print_debug(level_data)
		if level_data.shop_items[0].item != null:
			shop_node.shop_items_resource = level_data.shop_items
		print_debug(level_data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
