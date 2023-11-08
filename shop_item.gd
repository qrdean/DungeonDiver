class_name ShopItem extends Area2D

@export var item_scene: PackedScene

@onready var sprite_2d: Sprite2D = $Sprite2D

var shop_item_resource: ShopItemResource : set = _set_shop_item_resource
var texture: Texture = null
var offset := Vector2(0.0, 40.0)

func _set_shop_item_resource(resource: ShopItemResource):
	shop_item_resource = resource
	if resource.item.texture:
		texture = resource.item.texture

func _ready():
	if texture:
		sprite_2d.texture = texture

	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exit)

func _on_body_entered(body: Node2D):
	if body is Player:
		body.attempt_interact.connect(_player_buy_item.bind(body))

func _on_body_exit(body: Node2D):
	if body is Player:
		body.attempt_interact.disconnect(_player_buy_item.bind(body))

# Dunno about passing around the player ref. It's probably fine
func _player_buy_item(player: Player):
	if player.currency >= shop_item_resource.cost:
		_spawn_item()
		player.remove_currency(shop_item_resource.cost)
	else:
		print_debug("can not buy")

func _spawn_item():
	var item = item_scene.instantiate()
	item.resource = shop_item_resource.item
	item.global_position = self.position + offset
	call_deferred("add_sibling", item)
	queue_free()
