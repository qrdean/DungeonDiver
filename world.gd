class_name World extends Node2D

@onready var item_scene = preload("res://item.tscn")

@onready var left_decision = $LeftDecision
@onready var right_decision = $RightDecision

signal change_level(level_data: LevelData, decision: String)

var root_node: LevelTree.TreeNode
var current_node: LevelTree.TreeNode
# Called when the node enters the scene tree for the first time.
func _ready():
	# We can now pass this node around as level data. Should set a current position on 
	# the node to load current level data. 
	# root_node = LevelTree.generate_binary_tree(2)
	# LevelTree.inOrderTraversal(root_node) 
	# current_node = root_node

	# print_debug(current_node.id)

	left_decision.body_entered.connect(_on_player_enter_left)
	left_decision.body_exited.connect(_on_player_exit_left)

	right_decision.body_entered.connect(_on_player_enter_right)
	right_decision.body_exited.connect(_on_player_exit_right)
	# print_debug(root_node)

## Example of getting the static resource file from the base resource class in code.
## just a static function that returns a WeaponResource using load(path_to_resource)
func spawn_an_item():
	var item: Item = item_scene.instantiate()
	item.resource = WeaponResource.get_pistol_resource()
	item.global_position = Vector2(125.0, 125.0)
	call_deferred("add_child", item)


func _on_player_enter_left(body: Node2D):
	if body is Player:
		body.attempt_interact.connect(_left_decision)

func _on_player_exit_left(body: Node2D):
	if body is Player:
		if body.attempt_interact.is_connected(_left_decision):
			body.attempt_interact.disconnect(_left_decision)

func _left_decision():
	if current_node.left == null:
		print_debug("we've reached the end")
		return

	change_level.emit(current_node.left.level_data, "left") 
	# print_debug("going down left path")
	# print_debug(current_node.right.level_data.id)
	# print_debug(current_node.right.level_data.level_type)
	current_node = current_node.left

func _on_player_enter_right(body: Node2D):
	if body is Player:
		body.attempt_interact.connect(_right_decision)

func _on_player_exit_right(body: Node2D):
	if body is Player:
		if body.attempt_interact.is_connected(_right_decision):
			body.attempt_interact.disconnect(_right_decision)

func _right_decision():
	if current_node.right == null:
		print_debug("we've reached the end")
		return

	change_level.emit(current_node.right.level_data, "right") 
	# print_debug("going down right path")
	# print_debug(current_node.right.level_data.id)
	# print_debug(current_node.right.level_data.level_type)
	current_node = current_node.right
