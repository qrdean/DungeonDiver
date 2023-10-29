class_name Sword extends Node2D

@onready var hitbox: Area2D = $Area2D
@onready var timer: Timer = $Timer

var active = false : set = _set_active

func _set_active(val):
	active = val
	hitbox.monitoring = active
	if active:
		timer.start()

func _ready():
	timer.timeout.connect(_on_sword_timeout)
	hitbox.body_entered.connect(_on_body_entered)

func _on_sword_timeout():
	active = false

func _on_body_entered(body):
	if body is Enemy:
		body.take_damage()
