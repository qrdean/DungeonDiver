class_name BaseEnemyResource extends Resource

@export var health: int  
@export var move_speed: float
@export var attack_speed: float

@export var currency: int

func _init(p_health = 0, p_move_speed = 0.0, p_attack_speed = 0.0, p_currency = 0):
	health = p_health
	move_speed = p_move_speed
	attack_speed = p_attack_speed
	currency = p_currency

