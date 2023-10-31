class_name Sword extends Node2D

@onready var hitbox: Area2D = $Area2D
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

var knockback_power = 250.0

var sword_facing_direction: Vector2 = Vector2(0.0, knockback_power)

var active = false 

func set_direction(dir: String):
	if dir == "down":
		sword_facing_direction = Vector2(0.0, knockback_power)
		animation_player.flip_h = false
		animation_player.flip_v = false
		animation_player.rotation_degrees = 0
	if dir == "up":
		sword_facing_direction = Vector2(0.0, -knockback_power)
		animation_player.flip_h = false
		animation_player.flip_v = true
		animation_player.rotation_degrees = 0
	if dir == "left":
		sword_facing_direction = Vector2(-knockback_power, 0.0)
		animation_player.flip_v = true
		animation_player.rotation_degrees = -90
	if dir == "right":
		sword_facing_direction = Vector2(knockback_power, 0.0)
		animation_player.flip_v = true
		animation_player.rotation_degrees = 90

func swing():
	if !active:
		active = true
		animation_player.visible = true
		animation_player.play("attack")
		hitbox.monitoring = true

func _ready():
	hitbox.body_entered.connect(_on_body_entered)
	animation_player.animation_finished.connect(_on_sword_timeout)

func _on_sword_timeout():
	active = false
	hitbox.monitoring = false
	animation_player.visible = false

func _on_body_entered(body):
	if body is Enemy:
		body.take_damage(sword_facing_direction)

