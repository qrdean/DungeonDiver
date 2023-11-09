class_name LevelTree extends Node

class TreeNode:
	var left: TreeNode
	var right: TreeNode
	var level_data: String

# class BinaryTree:
static func init_tree_node(level_data: String) -> TreeNode:
	var tree_node = TreeNode.new()
	tree_node.left = null
	tree_node.right = null
	tree_node.level_data = level_data
	return tree_node

static func generate_binary_tree(depth: int):
	if depth == 0:
		return init_tree_node("root")

	var queue: Array[TreeNode] = []
	var i := 0

	var root: TreeNode = init_tree_node("root")
	queue.append(root)

	while len(queue) > 0:
		var size = len(queue)

		i += 1
		if i > depth:
			break
		else:
			for j in range(size):
				var node: TreeNode = queue.pop_front()
				node.left = init_tree_node(str(i))
				node.right = init_tree_node(str(i))

				queue.append(node.left)
				queue.append(node.right)

	return root
		
static func inOrderTraversal(node: TreeNode):
	if node == null:
		return
	
	inOrderTraversal(node.left)
	print_debug(node.level_data)
	inOrderTraversal(node.right)

