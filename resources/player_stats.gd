class_name PlayerStats extends Resource

@export var attack_damage: int
@export var armor: int
@export var max_health: int
@export var max_mana: int

func _init(
	p_attack_damage = 0,
	p_armor = 0,
	p_max_health = 0,
	p_max_mana = 0,
):
	attack_damage = p_attack_damage
	armor = p_armor
	max_health = p_max_health
	max_mana = p_max_mana
