class_name ItemResource extends Resource

enum ItemType {
	WEAPON,
	ARMOR,
	POTION,
	COIN
}

@export var type: ItemType
@export var stats: int
@export var texture: Texture2D

func _init(p_type = ItemType.WEAPON, p_stats = 0, p_texture = null):
	type = p_type
	stats = p_stats
	texture = p_texture

