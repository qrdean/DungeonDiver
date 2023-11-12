class_name SceneManager extends Node

@onready var current_level: World = $World

var root_node: LevelTree.TreeNode
var current_node: LevelTree.TreeNode

# Called when the node enters the scene tree for the first time.
func _ready():

	root_node = LevelTree.generate_binary_tree(5)
	# LevelTree.inOrderTraversal(root_node) 
	current_node = root_node

	current_level.change_level.connect(handle_level_changed)

func handle_level_changed(decision: World.LevelDecision):
	var next_node: LevelTree.TreeNode = get_next_node(decision)
	if (!next_node):
		print_debug("we've reached the end of the tree struct")
		print_debug("double check each path tho")
		if current_node.left != null:
			next_node = current_node.left
		elif current_node.right != null:
			next_node = current_node.left
		else:
			return

	var next_level_scene := load(next_node.level_data.scene_path)
	if next_level_scene == null:
		print_debug("scene path is null")
		return

	var next_level: World = next_level_scene.instantiate()
	add_child(next_level)
	next_level.change_level.connect(handle_level_changed)
	next_level.level_data = next_node.level_data
	current_node = next_node
	current_level.queue_free()
	current_level = next_level

func get_next_node(decision: World.LevelDecision) -> LevelTree.TreeNode:
	match decision:
		World.LevelDecision.LEFT:
			return current_node.left
		World.LevelDecision.RIGHT:
			return current_node.right
	return null

func set_next_tree_node(new_node, new_level):
	new_level.current_node = new_node 
