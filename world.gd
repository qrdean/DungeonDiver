class_name World extends Node2D

@onready var item_scene = preload("res://item.tscn")

@onready var left_decision = $LeftDecision
@onready var right_decision = $RightDecision

signal change_level(decision: LevelDecision)

enum LevelDecision{
	LEFT,
	RIGHT
}

var level_data: LevelData

func _ready():
	left_decision.body_entered.connect(_on_player_enter_left)
	left_decision.body_exited.connect(_on_player_exit_left)

	right_decision.body_entered.connect(_on_player_enter_right)
	right_decision.body_exited.connect(_on_player_exit_right)

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
	change_level.emit(LevelDecision.LEFT) 

func _on_player_enter_right(body: Node2D):
	if body is Player:
		body.attempt_interact.connect(_right_decision)

func _on_player_exit_right(body: Node2D):
	if body is Player:
		if body.attempt_interact.is_connected(_right_decision):
			body.attempt_interact.disconnect(_right_decision)

func _right_decision():
	change_level.emit(LevelDecision.LEFT) 
