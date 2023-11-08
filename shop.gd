class_name Shop extends Node2D

@export var shop_items_resource: Array[ShopItemResource]
@export var shop_item_scene: PackedScene

@onready var shop_items_node: Node2D = $ShopItems

var item_offset: int = 40

func _ready():
	var x_placement = 5
	for item in shop_items_resource:
		_spawn_item(item, x_placement)
		x_placement += item_offset

func _spawn_item(item: ShopItemResource, x_placement: int):
	var shop_item: ShopItem = shop_item_scene.instantiate()
	shop_item.position.x = x_placement
	shop_item.shop_item_resource = item
	shop_items_node.call_deferred("add_child", shop_item)
