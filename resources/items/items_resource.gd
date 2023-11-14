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

enum ItemsList {
	HEALTH_POTION,
  LEATHER_ARMOR 
}

# Contains a list of items that are not unique to the game world
static var item_resource_path_dictionary: Dictionary = {
	ItemsList.HEALTH_POTION: "res://resources/items/health_potion.tres",
	ItemsList.LEATHER_ARMOR: "res://resources/items/leather_armor.tres"
}

static func get_item_resource_path_dictionary() -> Dictionary:
	return item_resource_path_dictionary

# Contains a list of the unique items of the game world
static var unique_item_resource_path_dictionary: Dictionary = {
	ItemsList.HEALTH_POTION: "res://resources/items/health_potion.tres",
	ItemsList.LEATHER_ARMOR: "res://resources/items/leather_armor.tres"
}

static func get_random_resource_path() -> String:
	return item_resource_path_dictionary[randi() % item_resource_path_dictionary.size()]

static func get_health_potion_resource() -> ItemResource:
	return load(item_resource_path_dictionary[ItemsList.HEALTH_POTION]) as ItemResource

static func get_leather_armor_resource() -> ItemResource:
	return load(item_resource_path_dictionary[ItemsList.LEATHER_ARMOR]) as ItemResource

