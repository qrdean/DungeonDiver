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

	var queue: Array[TreeNode] = []
	var i := 0

	var root: TreeNode = init_tree_node(root_level_data)
	queue.append(root)

	while len(queue) > 0:
		var size = len(queue)

		i += 1
		if i > depth:
			break
		else:
			for j in range(size):
				var node: TreeNode = queue.pop_front()
				var path = "res://levels/depth/" + str(i) + "/level.tscn"
				var left_level_data = LevelData.new_level_type(id, LevelData.LevelType.COMBAT, null, path)
				id += 1
				var right_level_data = LevelData.new_level_type(id, LevelData.LevelType.COMBAT, null, path)
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

