class_name ShopItemResource extends Resource

@export var cost: int
@export var item: ItemResource

func _init(p_cost = 0, p_item = null):
	cost = p_cost
	item = p_item

