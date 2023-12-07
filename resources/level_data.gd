class_name LevelData extends Resource

enum LevelType {
	START,
	COMBAT,
	SHOP,
	BOSS,
}

@export var id: int
@export var level_type: LevelType
@export var reward_item: ItemResource
@export var shop_items: Array[ShopItemResource]

@export var scene_path: String


func _init(p_id = 0, p_level_type = LevelType.COMBAT, p_reward_item = null, p_shop_items:Array[ShopItemResource] = [null], p_scene_path = ""):
	id = p_id
	level_type = p_level_type
	reward_item = p_reward_item
	shop_items = p_shop_items
	scene_path = p_scene_path

# Dictionary 
static func new_level_type(p_id: int, p_level_type: LevelType, p_reward_item: ItemResource, p_scene_path: String) -> LevelData:
	var level_data = LevelData.new(p_id, p_level_type, p_reward_item, [ShopItemResource.new()], p_scene_path)
	return level_data

static func new_level_type_shop(p_id: int, p_level_type: LevelType, p_reward_item: ItemResource, p_shop_items: Array[ShopItemResource], p_scene_path: String) -> LevelData:
	var level_data = LevelData.new(p_id, p_level_type, p_reward_item, p_shop_items, p_scene_path)
	return level_data
