class_name SceneManager extends Node

@onready var current_level: World = $World

var root_node: LevelTree.TreeNode
var current_node: LevelTree.TreeNode

# Called when the node enters the scene tree for the first time.
func _ready():

	root_node = LevelTree.generate_binary_tree(2)
	LevelTree.inOrderTraversal(root_node) 
	current_node = root_node

	current_level.current_node = current_node

	current_level.change_level.connect(handle_level_changed)

func handle_level_changed(level_data: LevelData, decision: String):
	print_debug(level_data.scene_path)
	var next_level_scene := load(level_data.scene_path)
	if next_level_scene == null:
		return

	var next_node: LevelTree.TreeNode
	if decision == "left":
		next_node = current_level.current_node.left
	elif decision == "right":
		next_node = current_level.current_node.right
	else:
		return

	var next_level: World = next_level_scene.instantiate()
	add_child(next_level)
	next_level.change_level.connect(handle_level_changed)
	next_level.current_node = next_node
	current_node = next_node
	current_level.queue_free()
	current_level = next_level
	print_debug(current_level.current_node.level_data.id)
