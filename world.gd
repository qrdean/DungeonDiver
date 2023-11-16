class_name World extends Node2D

@onready var item_scene = preload("res://item.tscn")
@onready var left_decision: Area2D = $LeftDecision
@onready var right_decision: Area2D = $RightDecision
@onready var player: Player = $Player
@onready var wave_manager: WaveManager = $Spawner

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
	
	if level_data:
		level_type_check(level_data.level_type)
	else:
		print_debug("we are at the start or not combat room")

func level_type_check(level_type: LevelData.LevelType):
	if level_type == null:
		print_debug('level type is null')
		return

	match level_type:
		LevelData.LevelType.START:
			print_debug("start")
		LevelData.LevelType.COMBAT:
			left_decision.visible = false
			right_decision.visible = false
			wave_manager.level_beaten.connect(room_beaten)
			wave_manager.wave_start()
		LevelData.LevelType.SHOP:
			left_decision.visible = true
			right_decision.visible = true
			# check for and initialize shop here
		LevelData.LevelType.BOSS:
			left_decision.visible = false
			right_decision.visible = false
			wave_manager.level_beaten.connect(room_beaten)
			wave_manager.boss_wave()
		_:
			print_debug('not a valid level_type')
			pass

## Example of getting the static resource file from the base resource class in code.
## just a static function that returns a WeaponResource using load(path_to_resource)
func room_beaten():
	left_decision.visible = true
	right_decision.visible = true

	if level_data and level_data.reward_item:
		var item: Item = item_scene.instantiate()
		item.resource = level_data.reward_item
		## Make a marker for visual purposes
		item.global_position = Vector2(125.0, 125.0)
		call_deferred("add_child", item)

func _on_player_enter_left(body: Node2D):
	if !left_decision.visible: 
		return

	if body is Player:
		body.attempt_interact.connect(_left_decision)

func _on_player_exit_left(body: Node2D):
	if body is Player:
		if body.attempt_interact.is_connected(_left_decision):
			body.attempt_interact.disconnect(_left_decision)

func _left_decision():
	change_level.emit(LevelDecision.LEFT) 

func _on_player_enter_right(body: Node2D):
	if !right_decision.visible:
		return

	if body is Player:
		body.attempt_interact.connect(_right_decision)

func _on_player_exit_right(body: Node2D):
	if body is Player:
		if body.attempt_interact.is_connected(_right_decision):
			body.attempt_interact.disconnect(_right_decision)

func _right_decision():
	change_level.emit(LevelDecision.LEFT) 
