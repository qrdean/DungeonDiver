class_name ItemChest extends Node2D

@export var item_scene: PackedScene
@export var item_resource: ItemResource

@onready var interactable_area: Area2D = $interactable_area

var opened := false

var offset := Vector2(0.0, 40.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	interactable_area.body_entered.connect(_on_body_entered)
	interactable_area.body_exited.connect(_on_body_exit)

func _on_body_entered(body: Node2D):
	if body is Player:
		body.attempt_interact.connect(_open_chest)

func _on_body_exit(body: Node2D):
	if body is Player:
		body.attempt_interact.disconnect(_open_chest)

func _open_chest():
	if !opened:
		opened = true
		var item = item_scene.instantiate()
		item.resource = item_resource
		item.global_position = self.global_position + offset
		call_deferred("add_sibling", item)
