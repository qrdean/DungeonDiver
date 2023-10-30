class_name PickupArea extends Area2D

signal item_pickup(resource: Item)
# Called when the node enters the scene tree for the first time.
func _ready():
	self.area_entered.connect(_item_pickup)

func _item_pickup(area: Node2D):
	if area.get_parent() != null and area.get_parent() is Item:
		var item = area.get_parent() as Item
		item_pickup.emit(item)
