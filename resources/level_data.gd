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
@export var scene_path: String

func _init(p_id = 0, p_level_type = LevelType.COMBAT, p_reward_item = null, p_scene_path = ""):
	id = p_id
	level_type = p_level_type
	reward_item = p_reward_item
	scene_path = p_scene_path

static func new_level_type(p_id, p_level_type, p_reward_item, p_scene_path) -> LevelData:
	var level_data = LevelData.new()
	level_data.id = p_id
	level_data.level_type = p_level_type
	level_data.reward_item = p_reward_item
	level_data.scene_path = p_scene_path
	return level_data

