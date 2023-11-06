class_name BulletResource extends Resource

@export var bullet_speed: int
@export var knockback_power: float
@export var texture: Texture2D

func _init(p_bullet_speed = 400, p_knockback_power = 100.0, p_texture = null):
	bullet_speed = p_bullet_speed
	knockback_power = p_knockback_power 
	texture = p_texture
