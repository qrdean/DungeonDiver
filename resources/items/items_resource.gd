class_name ItemResource extends Resource

enum ItemType {
	WEAPON,
	ARMOR,
	POTION
}

enum PotionTypes {
	NONE,
	HEALTH,
	MANA,
}

@export var type: ItemType
@export var stats: int
@export var potion_sub_type: PotionTypes

func _init(p_type = ItemType.WEAPON, p_stats = 0, p_potion_sub_types = PotionTypes.NONE):
	type = p_type
	stats = p_stats
	potion_sub_type = p_potion_sub_types

