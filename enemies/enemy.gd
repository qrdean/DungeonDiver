class_name Enemy extends CharacterBody2D

var health: int = 3

func _ready():
	pass

func take_damage():
	health -= 1
	if health <= 0:
		self.queue_free()
