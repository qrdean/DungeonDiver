extends Node2D

@onready var item_scene = preload("res://item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

## Example of getting the static resource file from the base resource class in code.
## just a static function that returns a WeaponResource using load(path_to_resource)
func spawn_an_item():
	var item: Item = item_scene.instantiate()
	item.resource = WeaponResource.get_pistol_resource()
	item.global_position = Vector2(125.0, 125.0)
	call_deferred("add_child", item)
