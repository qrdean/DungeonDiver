class_name BaseEnemyResource extends Resource

@export var health: int  
@export var move_speed: float
@export var attack_speed: float

@export var radial_distance: int

@export var currency: int

@export var sprite_sheet: SpriteFrames

func _init(p_health = 1, p_move_speed = 100.0, p_attack_speed = 1.0, p_radial_distance = 100, p_currency = 1, p_sprite_frames = null):
	health = p_health
	move_speed = p_move_speed
	attack_speed = p_attack_speed
	radial_distance = p_radial_distance
	currency = p_currency
	sprite_sheet = p_sprite_frames

static func get_chaff_resource() -> BaseEnemyResource:
	return load("res://resources/enemies/chaff_enemy.tres") as BaseEnemyResource

static func get_boss_slime() -> BaseEnemyResource:
	return load("res://resources/enemies/boss_slime.tres") as BaseEnemyResource

