class_name Shop extends Node2D

@export var shop_items_resource: Array[ShopItemResource]
@export var shop_item_scene: PackedScene

@onready var shop_items_node: Node2D = $ShopItems

func _ready():
	var x_placement = 5
	for item in shop_items_resource:
		var shop_item: ShopItem = shop_item_scene.instantiate()
		shop_item.position.x = x_placement
		shop_item.set_sprite_texture(item.item.texture)
		$ShopItems.call_deferred("add_child", shop_item)
		x_placement += 25

func _print_shop_items():
	for res in shop_items_resource:
		print_debug(res.cost)
		print_debug(res.item)

