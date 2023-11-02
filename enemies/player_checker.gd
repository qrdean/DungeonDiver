extends Area2D

signal attack_player()
# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_check_for_player)

func _check_for_player(body: Node2D):
	if body is Player:
		attack_player.emit()

