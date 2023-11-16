class_name WaveManager extends Node


## need to pull from like a config for enemy variety 
@export var enemy_scene: PackedScene
@export var spawn_points: Array[Vector2] = []
@export var player: Player

const number_of_waves: int = 2
const enemies_per_wave: int = 4

var current_wave: int = 0
var enemies_dead: int = 0

signal level_beaten

func _ready():
	pass

func wave_start():
	enemies_dead = 0
	current_wave += 1
	for i in enemies_per_wave:
		spawn_enemy(i)

func spawn_enemy(i: int):
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.enemy_stats = BaseEnemyResource.get_chaff_resource()
	enemy_instance.player = player
	enemy_instance.global_position = spawn_points[i]
	enemy_instance.enemy_death.connect(_on_enemy_death)
	call_deferred("add_sibling", enemy_instance)

func wave_finish():
	if current_wave < number_of_waves:
		wave_start()
	else:
		level_beaten.emit()

func _on_enemy_death():
	enemies_dead += 1
	if enemies_dead >= enemies_per_wave:
		wave_finish()

func boss_wave():
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.enemy_stats = BaseEnemyResource.get_boss_slime()
	enemy_instance.player = player
	enemy_instance.global_position = spawn_points[0]
	enemy_instance.enemy_death.connect(_on_boss_death)
	call_deferred('add_sibling', enemy_instance)

func _on_boss_death():
	level_beaten.emit()
