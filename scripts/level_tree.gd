class_name LevelTree extends Node

class TreeNode:
	var left: TreeNode
	var right: TreeNode
	var level_data: LevelData

# class BinaryTree:
static func init_tree_node(level_data: LevelData) -> TreeNode:
	var tree_node = TreeNode.new()
	tree_node.left = null
	tree_node.right = null
	tree_node.level_data = level_data
	return tree_node

static func generate_binary_tree(depth: int):
	var id = 0
	var root_level_data = LevelData.new_level_type(id, LevelData.LevelType.START, null, "res://World.tscn")
	id += 1
	if depth == 0:
		return init_tree_node(root_level_data)

	var item_list: Dictionary = ItemResource.get_item_resource_path_dictionary()
	var weapon_list: Dictionary = WeaponResource.get_weapon_resource_path_dictionary()

	var queue: Array[TreeNode] = []
	var i := 0

	var shop_level_data = LevelData.new_level_type(0, LevelData.LevelType.SHOP, null, "res://levels/base_shop.tscn")
	var boss_level_data = LevelData.new_level_type(0, LevelData.LevelType.BOSS, null, "res://levels/boss_room.tscn")
	var root: TreeNode = init_tree_node(root_level_data)
	queue.append(root)

	var before_boss_shop_node: TreeNode = init_tree_node(shop_level_data)
	var boss_node: TreeNode = init_tree_node(boss_level_data)
	before_boss_shop_node.left = boss_node
	before_boss_shop_node.right = before_boss_shop_node.left

	while len(queue) > 0:
		var size = len(queue)

		i += 1
		if i > depth:
			for j in range(size):
				queue[j].left = before_boss_shop_node
				queue[j].right = queue[j].left
			break
		else:
			for j in range(size):
				var node: TreeNode = queue.pop_front()

				var item = get_level_item(weapon_list, item_list)

				var level_type_left := get_level_type(i)
				var level_type_right := get_level_type(i)

				var left_level_data = LevelData.new_level_type(id, level_type_left.level_type, item, level_type_left.path)
				id += 1
				var right_level_data = LevelData.new_level_type(id, level_type_right.level_type, item, level_type_right.path)
				id += 1
				node.left = init_tree_node(left_level_data)
				node.right = init_tree_node(right_level_data)

				queue.append(node.left)
				queue.append(node.right)

	return root
		
static func inOrderTraversal(node: TreeNode):
	if node == null:
		return
	
	inOrderTraversal(node.left)
	print_debug(str(node.level_data.level_type))
	print_debug("id " + str(node.level_data.id))
	inOrderTraversal(node.right)

static func get_level_item(weapon_list: Dictionary, item_list: Dictionary) -> ItemResource:
		var item_path = null
		if get_a_weapon():
			item_path = get_random_item_path(weapon_list, false)
		else:
			item_path = get_random_item_path(item_list, false)

		if item_path != null:
			return load(item_path) as ItemResource
		return null


static func get_random_item_path(item_list: Dictionary, unique: bool):
	if item_list.size() <= 0:
		return null

	var index = randi() % item_list.size()
	var item_path = item_list[index]
	if item_path == null:
		return null

	if unique:
		var success = item_list.erase(index)
		print_debug(success)

	return item_path


# TODO: Should refactor this to return a type of item. AKA Weapon, Unique, Regular based on some weighted 
# for now just returns if we want a weapon or not
static func get_a_weapon() -> bool:
	return randi() % 2

static func get_level_type(current_depth: int) -> Dictionary:
	var combat_path = "res://levels/depth/" + str(current_depth) + "/level.tscn"
	var shop_path = "res://levels/base_shop.tscn"
	var dict := {"level_type": null, "path": null}
	if current_depth > 1:
		if randi() % current_depth:
			dict.level_type = LevelData.LevelType.SHOP
			dict.path = shop_path
			return dict
		else:
			dict.level_type = LevelData.LevelType.COMBAT
			dict.path = combat_path
			return dict
	else:
		dict.level_type = LevelData.LevelType.COMBAT
		dict.path = combat_path
		return dict
